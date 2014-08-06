
require 'mustache'
require 'spectra/components'
require 'spectra/utilities/extensions'
require 'spectra/views/serializable'

module Spectra

  class View < Mustache

    include Serializable

    attr_accessor :colors, :renamer, :prefix

    def initialize(attributes)
      self.directory = attributes[:directory]
      self.filename  = attributes[:filename]
      self.renamer   = attributes[:renamer]
    end

    def self.from_attributes(attributes)
      [ self.new(attributes) ]
    end

    ##
    ## Mustache
    ##

    self.path = File.dirname(__FILE__) 
     
    def self.template_name
       super.split('/').last
    end  

    ##
    ## Rendering
    ##

    def render(attributes)
      self.prefix = attributes[:prefix]
      self.colors = self.views_from_colors(attributes[:colors])
      super() # offload to Mustache
    end

    def views_from_colors(colors)
      colors.map do |color| 
        ColorView.new(color, {
          name:  proc { |c| self.format_color_name(c) },
          value: proc { |v| self.format_color_value(v) }
        }) 
      end
    end

    def format_color_name(name)
      self.renamer.call(name, self.prefix)
    end

    def format_color_value(value)
      '%.2f' % (value || 0.0)
    end 

    ##
    ## Debugging
    ##

    def to_s
      "<#{self.class.name} => #{self.path}, renamer: #{@renamer}>"
    end

  end

  class ColorView

    attr_accessor :color, :formatters
    
    def initialize(color, formatters)    
      self.color = color 
      self.formatters = formatters
    end

    def respond_to?(name)
      super || self.color.respond_to?(name)
    end

    def method_missing(name, *args)
      if Components.valid?(name)
        self.format(:value, self.color.send(name, *args))
      else
        super
      end
    end

    ##
    ## Accessors
    ##

    def name
      self.format(:name, self.color.name)
    end

    def hex
      self.format(:value, Components.hexify(self.color.components))
    end    

    def format(type, value)
      self.formatters[type].call(value)
    end 

    ##
    ## Debugging
    ##

    def to_s
      "<view => #{self.color}>"
    end

  end

end

