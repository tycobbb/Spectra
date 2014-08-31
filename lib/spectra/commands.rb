
require 'claide'

module Spectra

class Command < CLAide::Command 
 
  self.abstract_command = true
  self.default_subcommand = 'generate'

  self.command = 'spectra'
  self.summary = 'Serializes colors into a variety of filetypes using a convenient ruby DSL'

  ##
  ## Subcommands
  ##
  
  class Generate < Command 
   
    self.summary = 'Serializes output color files (default)'

    self.description = <<-DESC
      If no subcommand is specified, this is the default.

      Processes and generates files from the spectrum.rb file in the current directory. Colors
      specified therein will be serialized into the denoted filetypes, overwriting any existing
      files at those locations.
    DESC

    def run
      begin
        definition = IO.read('spectrum.rb')
      rescue Exception
        raise Informative, 'Failed to find a spectrum.rb file in the current directory'
      end 

      spectrum = Spectrum.new
      spectrum.generate(definition)
    end

  end

  class Init < Command
    
    self.summary = 'Creates a template spectrum.rb file' 

    self.description = <<-DESC
      Creates a template spectrum.rb file in the current directiory. The template file contains
      instructional defaults to demonstrate spectra's features to the uninitiated.
    DESC

    def run
      begin
        IO.copy_stream(File.dirname(__FILE__) + '/spectra/template.rb', 'spectrum.rb')
      rescue Exception 
        raise Informative, 'Failed to create spectrum.rb file'
      else
        logger.verbose "created #{Dir.pwd}/spectrum.rb"
      end
    end

  end     

end

end # module 

