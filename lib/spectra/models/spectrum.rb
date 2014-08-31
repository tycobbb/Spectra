
require 'spectra/color'
require 'spectra/views/factory'

module Spectra
  class Spectrum 
    
    attr_accessor :_prefix
    attr_accessor :colors, :views

    def generate(definition)
      # evaluate color definition file, setup defaults
      self.instance_eval(definition)
      self.formats(:palette, :objc) unless self.views

      # render views according to the specification
      self.views.each do |view|
        view.serialize({ colors: self.colors, prefix: self._prefix })
      end
    end 

    ##
    ## DSL
    ##

    def prefix(prefix)
      self._prefix = prefix 
    end
  
    def formats(*types) 
      types.each { |type| format(type) }
    end

    def format(type, directory = nil, &renamer)
      self.views ||= []
      self.views.concat(Views.from_attributes({ type: type, directory: directory, renamer: renamer }))
    end
     
    def color(name, attributes)
      self.colors ||= [] 
      self.colors << Color.new(name, Components.componentize(attributes))
    end

    def components(*components)
      components.hash_from(:red, :green, :blue, :alpha)
    end

    def hex(*components)
      components.hash_from(:hex, :alpha)
    end

    def white(*components)
      components.hash_from(:white, :alpha)
    end 
  end
end

