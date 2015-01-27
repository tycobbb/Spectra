
require 'claide'
require 'spectra/models/spectrum'

module Spectra

class Command < CLAide::Command 
 
  self.abstract_command = true

  self.command = 'spectra'
  self.summary = 'Serializes colors into a variety of filetypes using a convenient ruby DSL'
  self.version = VERSION

  def initialize(argv)
    Spectra.logger.parse_argv(argv)
    super
  end

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

    def self.options
      [[
        '--dry-run', 'Prints the would-be output file rather than generating anything' 
      ]].concat(super)
    end

    def initialize(argv)
      # update config from options 
      Config.dry_run = argv.flag?('dry-run', false)
      super
    end

    def validate!
      super
      begin
        @definition = IO.read('spectrum.rb')
      rescue Exception
        raise Informative, 'Failed to find a spectrum.rb file in the current directory'
      end 
    end

    def run
      # generate the views from the user's spectrum.rb
      spectrum = Spectra::Spectrum.new
      spectrum.generate(@definition)
    end

  end

  class Init < Command

    attr_accessor :source, :destination
    
    self.summary = 'Creates a template spectrum.rb file' 

    self.description = <<-DESC
      Creates a template spectrum.rb file in the current directiory. The template file contains
      instructional defaults to demonstrate spectra's features to the uninitiated.
    DESC

    def initialize(argv)
      super
      self.source = File.dirname(__FILE__) + '/template.rb'
      self.destination = "#{Dir.pwd}/spectrum.rb"
    end

    def validate!
      super 
      raise Informative, "#{self.destination} already exists" if File.file?(self.destination) 
    end
    
    def run
      begin
        IO.copy_stream(self.source, self.destination)
      rescue Exception => exception
        message  = 'Failed to create spectrum.rb'
        message += "\n#{exception}"
        raise Informative, message
      else
        Spectra.logger.info "[✓] Created #{self.destination}"
      end
    end

  end     

end

end # module 

