
##
## Exception
##

require 'claide'

module Spectra
  class Informative < Exception
  
    include CLAide::InformativeError

    def message
      "[!] #{super}".ansi.red
    end 

  end
end

##
## Logger
##

require 'logger'

module Spectra
  class << self
    attr_accessor :logger
  end

  def self.logger
    @logger ||= Logger.new(STDOUT)
  end
end

##
## Extensions
##

class Numeric 
  def limit(range)
    self > range.max ? range.max : self < range.min ? range.min : self
  end 
end

class Symbol  
  def camelize(pascal)
    self.to_s.split('_').map.with_index do |component, index| 
      !pascal && index == 0 ? component : component.capitalize 
    end.join('') 
  end
end

class Array 
  def hash_from(*keys)
    Hash[ keys.first(self.length).zip(self) ]
  end
end

class Hash
  def pick(*keys)
    self.select { |key, value| keys.include?(key) }
  end

  def deep_merge(hash)
    worker = proc do |key, source, update|
      if source.is_a?(Hash) && update.is_a?(Hash)
        source.merge(update, &worker)
      else
        update
      end
    end
    self.merge(hash, &worker)
  end
end

