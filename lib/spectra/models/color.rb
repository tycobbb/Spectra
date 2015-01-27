
require 'spectra/models/components'

module Spectra

  class Color
    
    attr_accessor :name, :suffix, :components
   
    def initialize(name, components)
      self.name, self.suffix = self.parse_name(name)
      self.components = components
    end 

    def parse_name(name)
      name_parts = name.to_s.split(/(\d+)/)
      return name_parts.first, name_parts[1] || ''
    end

    ##
    ## Forwarding
    ##

    def respond_to?(name)
      super || Components.valid?(name)
    end

    def method_missing(name)
      Components.valid?(name) ? self.components[name] : super
    end

    ##
    ## Debugging
    ##

    def to_s
      string = "color '#{name}'"
      string = [ :red, :green, :blue, :alpha ].inject(string) do |memo, key| 
        memo + ' ' + key.to_s[0] + ' %.2f' % (self.components[key] || 0.0)
      end
    end

  end

end

