
require 'spectra/templates/template'

module Spectra

  class SwiftExtension < Template
    
    def renamer
      @renamer ||= lambda { |name, prefix| name.camelize(true) } 
    end 

    ##
    ## Pathing
    ##

    def filename
      return 'Colors.swift' 
    end

  end

end

