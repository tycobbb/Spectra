
require 'spectra/version'
require 'models'

module Spectra
  
  def self.generate
    Root.new.generate
  end 

end

