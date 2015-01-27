
require 'spectra/views/view'

module Spectra

  class Palette < View

    def renamer
      @renamer || lambda { |color, prefix| color.name.camelize(true) + color.suffix }
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

