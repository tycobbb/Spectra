
module Spectra
  
  class << self
    attr_accessor :logger
  end

  def self.logger
    @logger ||= Logger.new(STDOUT)
  end

  require 'spectra/version'
  require 'spectra/extensions'
  require 'spectra/commands'

end

