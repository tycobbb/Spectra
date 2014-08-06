
require 'spectra/views/view'

module Spectra

  class Palette < View

    def renamer
      @renamer || lambda { |name, prefix| name.camelize(true) }
    end

    ##
    ## Pathing 
    ##
    
    def directory 
      @directory || "#{Dir.home}/Library/Colors/"
    end

    def filename
      super || "#{self.prefix}-palette.clr"
    end

  end 

end

