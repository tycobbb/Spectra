
require 'spectra/components'
require 'spectra/utilities/extensions'

module Spectra

  class Color
    
    attr_accessor :name, :components
   
    def initialize(name, components)
      self.name = name
      self.components = components
    end 

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
      "<color: #{name} colors: #{components.values_at(:red, :green, :blue, :alpha).map{|v| '%.2f' % (v || 0.0) }}>" 
    end

  end

end

