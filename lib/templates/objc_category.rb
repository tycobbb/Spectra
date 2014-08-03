
require 'templates/template'

module Spectra

  class ObjcCategory < Template
    
    attr_accessor :is_header

    def initialize(attributes)
      super 
      self.is_header = attributes[:is_header]
    end

    ##
    ## Templating
    ##

    def class_prefix
      self.prefix.upcase
    end

    def file_keyword
      self.is_header ? "interface" : "implementation"
    end

    def file_extension
      self.is_header ? 'h' : 'm'
    end

    ##
    ## Formatting
    ##

    def format_color_value(value)
      '%.2f' % (value || 0.0) + 'f' 
    end

    def renamer
      @renamer ||= lambda { |name, prefix| "#{prefix}_#{name.camelize(false)}Color" }
    end
    
    ##
    ## Pathing Hooks
    ##

    def filename
      "UIColor+#{self.class_prefix}Color.#{self.file_extension}"
    end
  
  end

end

