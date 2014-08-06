
require 'spectra/version'
require 'spectra/spectrum'
require 'spectra/utilities/logger'

module Spectra
  
  class << self
    attr_accessor :logger, :options 
  end 
 
  def self.generate(options)
    self.options = options
    logger.level = options.verbose ? Logger::DEBUG : Logger::INFO

    begin
      definition = IO.read('spectrum.rb')
    rescue Exception => execption
      logger.terminate "Failed to read spectrum.rb file: #{execption}" 
    end 

    spectrum = Spectrum.new
    spectrum.generate(definition)
  end 

  def self.logger
    @logger ||= SpectraLogger.new(STDOUT) 
  end

end

