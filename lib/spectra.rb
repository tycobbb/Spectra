
require 'spectra/version'
require 'spectra/spectrum'
require 'spectra/utilities/logger'

module Spectra
  
  class << self
    attr_accessor :logger, :options
  end 
 
  def self.generate(options)
    self.options = options

    begin
      definition = IO.read('spectrum.rb')
    rescue Exception => execption
      logger.terminate "Failed to read spectrum.rb file: #{execption}" 
    end 

    spectrum = Spectrum.new
    spectrum.generate(definition)
  end 

  def self.create(options)
    self.options = options

    begin
      IO.copy_stream(File.dirname(__FILE__) + '/spectra/template.rb', 'spectrum.rb')
    rescue Exception => exception
      logger.terminate "Failed to create spectrum.rb file: #{exception}"
    else
      logger.info "created #{Dir.pwd}/spectrum.rb"
    end
  end

  def self.logger
    @logger ||= SpectraLogger.new(STDOUT) 
  end

  def options=(options)
    @options = options
    self.logger.level = options.verbose ? Logger::DEBUG : Logger::INFO
  end

end

