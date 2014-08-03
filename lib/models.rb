
require 'extensions'
require 'dsl'

module Spectra

  class Root
    
    attr_accessor :_prefix
    attr_accessor :colors, :serializers

    include DSL

    def generate(definition) 
      self.instance_eval(definition)
      self.formats(:palette, :objc) unless self.serializers

      self.serializers.each do |serializer|
        serializer.serialize({
          colors: self.colors,
          prefix: self._prefix,  
        })
      end
    end 

  end

  class Color
    
    attr_accessor :name, :components

    class << self
      attr_accessor :valid_components
    end

    self.valid_components = [ :red, :green, :blue, :white, :alpha ]
    
    def initialize(name, attributes)
      self.name = name
      self.components = self.components_from_attributes(attributes)
    end 

    def respond_to?(name)
      super || self.class.valid_components.include?(name)
    end

    def method_missing(name)
      self.class.valid_components.include?(name) ? self.components[name] : super
    end

    ##
    ## Component Generation
    ##

    def components_from_attributes(attributes)
      components = map_attributes(attributes).pick(*self.class.valid_components)
      hex, white = attributes[:hex], components[:white]

      components[:alpha] ||= 1.0
      components.merge!(componentize_hex(hex)) if hex 
      components.merge!(componentize_white(white)) if white
      
      components.each { |key, value| components[key] = normalize(value) }
    end

    def componentize_hex(value)
      hex = value.is_a?(String) ? value.to_i : value
      return {
        red:   (hex & 0xFF0000) >> 16,
        green: (hex & 0x00FF00) >> 8,
        blue:  (hex & 0x0000FF)
      }    
    end

    def componentize_white(value)
      return { red: value, green: value, blue: value }
    end

    ##
    ## Helpers
    ##

    def normalize(number)
      number = number / 255.0 if number.is_a?(Fixnum)
      raise "component #{number} is not in a legible format" unless number.is_a?(Float)
      number.limit(0.0..1.0) 
    end
   
    def map_attributes(attributes)
      key_map = { r: :red, g: :green, b: :blue, w: :white, a: :alpha }
      return Hash[attributes.map { |key, value| [ key_map[key] || key, value ] }] 
    end

    ##
    ## Debugging
    ##

    def inspect
      return "#{self.name} :: #{self.components}" 
    end

  end

end

