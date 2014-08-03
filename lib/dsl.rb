
require 'components'
require 'serializer'

module Spectra

  module DSL
    def prefix(prefix)
      self._prefix = prefix 
    end
  
    def formats(*types) 
      types.each { |type| format(type) }
    end

    def format(type, path = nil, &renamer)
      self.serializers ||= []
      self.serializers.concat(Serializer.from_type(type, {
        path: path,
        template: { type: type, renamer: renamer }  
      }))
    end
     
    def color(name, attributes)
      self.colors ||= []
      components = Components.componentize(attributes)
      self.colors << Color.new(name, components)
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

