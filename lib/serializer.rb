
require 'extensions'
require 'templates/factory'

module Spectra

  class Serializer

    attr_accessor :template, :base_path

    def initialize(attributes)
      self.base_path = attributes[:path]
      self.template  = Template.from_attributes(attributes[:template])
    end

    def serialize(spectrum)
      path, text = self.resource_path(spectrum), self.template.format(spectrum)
      File.open(path, 'w+') { |file| file.write(text) }
    end

    def resource_path(spectrum)
      base_path = self.base_path || self.template.path
      base_path << '/' unless base_path.end_with?('/')
      base_path + self.template.filename(spectrum)
    end

    ##
    ## Factory
    ##

    def self.from_type(type, attributes)
      case type.intern
        when :palette, :swift
          [ Serializer.new(attributes) ]
        when :objc
          [ Serializer.new(attributes.deep_merge(template: { is_header: true })), Serializer.new(attributes) ]
        else raise "Specfied an invalid serializer type: #{type}"
      end
    end

  end

end

