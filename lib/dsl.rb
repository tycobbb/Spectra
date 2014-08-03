
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
      
      serializers = Serializer.from_type(type, {
        path: path,
        template: { type: type, renamer: renamer }  
      })
      self.serializers.concat(serializers)
      
      serializers.each { |serializer| Spectra.logger.debug "dsl add: #{serializer}" }
    end
     
    def color(name, attributes)
      self.colors ||= []
      
      color = Color.new(name, Components.componentize(attributes))
      self.colors << color

      Spectra.logger.debug "dsl add: #{color}"
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

