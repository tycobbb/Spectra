
require 'templates/palette'
require 'templates/objc_category'
require 'templates/swift_extension'

module Spectra

  class Template

    def self.from_attributes(attributes)
      case attributes[:type].intern
        when :palette
          Palette.new(attributes)
        when :objc    
          ObjcCategory.new(attributes)
        when :swift   
          SwiftExtension.new(attributes)
      end
    end

  end

end
