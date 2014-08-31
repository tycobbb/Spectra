
require 'claide'

module Spectra

class Command < CLAide::Command 
 
  self.abstract_command = true
  self.default_subcommand = 'generate'

  self.command = 'spectra'
  self.summary = 'Serializes colors into a variety of filetypes using a convenient ruby DSL'

  def initialize(argv)
    super 
  end

  ##
  ## Subcommands
  ##
  
  class Generate < Command 
   
    self.summary = 'Serializes output color files'

    self.description = <<-DESC
      If no subcommand is specified, this is the default.

      Processes and generates files from the spectrum.rb file in the current directory. Colors
      specified therein will be serialized into the denoted filetypes, overwriting any existing
      files at those locations.
    DESC

    def run
      begin
        definition = IO.read('spectrum.rb')
      rescue Exception => execption
        Spectra::logger.terminate "Failed to read spectrum.rb file: #{execption}" 
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
      rescue Exception => exception
        logger.terminate "Failed to create spectrum.rb file: #{exception}"
      else
        logger.info "created #{Dir.pwd}/spectrum.rb"
      end
    end

  end     

end

end # module 

