
require 'mustache'

module Spectra

  class Template < Mustache
   
    attr_accessor :renamer, :colors, :prefix
    
    def initialize(attributes)
      self.renamer = attributes[:renamer] 
    end 

    ##
    ## Mustache
    ##

    self.path = 'lib/templates'
     
    def self.template_name
       super.split('/').last
    end 
    
    ##
    ## Rendering 
    ## 

    def render(attributes)
      self.prefix = attributes[:prefix]
      self.colors = parse_colors(attributes[:colors])
      super() # offload to Mustache
    end

    def parse_colors(colors)
      colors.map { |color| self.parse_color(color) }
    end

    def parse_color(color)
      copy = color.clone  
      copy.name = self.format_color_name(color)
      copy.components = color.components.map do |key, value| 
        [ key, self.format_color_value(value) ] 
      end.to_h
      copy
    end

    def format_color_name(color)
      self.renamer.call(color.name, self.prefix)
    end

    def format_color_value(value)
      '%.2f' % (value || 0.0)
    end
    
    ##
    ## Pathing
    ##

    def path 
      './'
    end
    
  end

end
