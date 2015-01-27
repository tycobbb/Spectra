
require 'spectra/views/view'

module Spectra

  class SwiftExtension < View
    
    def renamer
      @renamer || lambda { |color, prefix| color.name.camelize(true) + color.suffix } 
    end 

    ##
    ## Pathing
    ##

    def filename
      super || 'Colors.swift' 
    end

  end

end

