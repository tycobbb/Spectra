
require 'spectra/views/view'

module Spectra

  class SwiftExtension < View
    
    def renamer
      @renamer || lambda { |name, prefix| name.camelize(true) } 
    end 

    ##
    ## Pathing
    ##

    def filename
      super || 'Colors.swift' 
    end

  end

end

