
module Spectra
  
  module Components    

    class << self
      attr_accessor :valid
    end
 
    self.valid = [ :red, :green, :blue, :white, :alpha ]
    
    def self.componentize(attributes)
      components = self.map_attributes(attributes).pick(*self.valid)
      hex, white = attributes[:hex], components[:white]

      components[:alpha] ||= 1.0
      components.merge!(self.componentize_hex(hex)) if hex 
      components.merge!(self.componentize_white(white)) if white
      
      puts components  
      components.each { |key, value| components[key] = self.normalize(value) }
    end

    def self.valid?(name)
      self.valid.include?(name)
    end

    ##
    ## Helpers
    ##

    def self.componentize_hex(value)
      hex = value.is_a?(String) ? value.to_i : value
      Hash.new.tap do |hash| 
        hash[:red]   = (hex & 0xFF0000) >> 16
        hash[:green] = (hex & 0x00FF00) >> 8
        hash[:blue]  = (hex & 0x0000FF)
      end
    end

    def self.componentize_white(value)
      { red: value, green: value, blue: value }
    end

    ##
    ## Helpers
    ##

    def self.normalize(number)
      number = number / 255.0 if number.is_a?(Fixnum)
      raise "component #{number} is not in a legible format" unless number.is_a?(Float)
      number.limit(0.0..1.0) 
    end
   
    def self.map_attributes(attributes)
      key_map = { r: :red, g: :green, b: :blue, w: :white, a: :alpha }
      return Hash[attributes.map { |key, value| [ key_map[key] || key, value ] }] 
    end

  end

end

