##
## Exceptions
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

  class Logger < Logger
    def parse_argv(argv)
      self.level = argv.flag?('verbose', false) ? Logger::DEBUG : Logger::INFO 
    end  
  end

  def self.logger
    unless @logger
      @logger = Spectra::Logger.new(STDOUT)
      @logger.formatter = proc { |sev, date, prog, msg| msg + "\n" }
    end
    
    @logger
  end
end

##
## Config
## 

module Spectra
module Config
  class << self 
    def attributes
      @attributes ||= {}
    end  

    def respond_to?(name)
      key = parse_name(name)
      super || self.attributes[key] 
    end

    def method_missing(name, *args)
      key, is_setter = parse_name(name)
      self.attributes[key] = args[0] if is_setter
      self.attributes[key]
    end

    def parse_name(name) 
      key, is_setter = name.intern, false
      
      if /^(\w+)=$/ =~ name
        key, is_setter = $1.intern, true
      end
      
      return key, is_setter 
    end
  end 
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

