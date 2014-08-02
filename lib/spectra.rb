
require 'spectra/version'
require 'models'
require 'serializer'

module Spectra
  
  def self.generate
    Root.new.generate
  end 

end

