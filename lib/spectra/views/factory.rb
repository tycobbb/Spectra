
require 'spectra/views/palette'
require 'spectra/views/objc_category'
require 'spectra/views/swift_extension'

module Spectra

  module Views

    def self.from_attributes(attributes)
      klass = self.view_class(attributes[:type]) 
      klass.from_attributes(attributes) 
    end

    def self.view_class(type)
      case type.intern
        when :palette
          Palette
        when :objc    
          ObjcCategory
        when :swift   
          SwiftExtension
      end
    end

  end

end
