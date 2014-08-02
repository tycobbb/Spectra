
require 'mustache'
require 'templates/template'

module Spectra

  class Palette < Mustache
    include Template

    def prefix(spectrum)
      "11"
    end

    def format_color(color, name)
      components = [ color.red, color.green, color.blue, color.alpha ]
      components.inject('0') { |memo, value| memo << ' ' << '%.3f' % (value || 0.0) } + " #{name}"
    end

    def renamer
      @renamer ||= lambda { |name, prefix| name.camelize(true) }
    end

    ##
    ## Pathing Hooks
    ##
    
    def path
      "#{Dir.home}/Library/Colors/"
    end

    def filename(spectrum)
      "#{spectrum._prefix}-palette.clr"
    end

    ##
    ## Helpers
    ##

    def format_value(value)
      '%.3f' % (value || 0.0)
    end

  end 

end

