
require 'spectra/templates/template'

module Spectra

  class Palette < Template

    def renamer
      @renamer ||= lambda { |name, prefix| name.camelize(true) }
    end

    ##
    ## Pathing 
    ##
    
    def path
      "#{Dir.home}/Library/Colors/"
    end

    def filename
      "#{self.prefix}-palette.clr"
    end

  end 

end

