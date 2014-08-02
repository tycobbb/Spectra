
module Spectra

  module Template 
   
    attr_accessor :renamer
    attr_accessor :post_prefix_newlines, :intercolor_newlines, :pre_suffix_newlines
    
    def initialize(attributes)
      self.renamer = attributes[:renamer] 
      self.post_prefix_newlines = self.intercolor_newlines = self.pre_suffix_newlines = 1
    end 

    ##
    ## Formatting
    ## 

    def format(spectrum)
      output = self.prefix(spectrum) + "\n" * self.post_prefix_newlines
      spectrum.colors.each_with_index { |color, index| output << format_indexed_color(color, index, spectrum) }
      output + "\n" * self.pre_suffix_newlines + self.suffix(spectrum)
    end

    def path
      './'
    end
    
    ##
    ## Helpers
    ##

    def format_indexed_color(color, index, spectrum)
      name     = self.format_name(color, spectrum)
      newlines = index < spectrum.colors.length - 1 ? self.intercolor_newlines : 0
      self.format_color(color, name) + "\n" * newlines
    end

    def format_name(color, spectrum)
      self.renamer.call(color.name, spectrum._prefix)
    end

    def prefix(spectrum)
      ""
    end

    def suffix(spectrum)
      ""
    end

  end

end
