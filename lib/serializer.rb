
require 'extensions'
require 'templates/factory'

module Spectra

  class Serializer

    attr_accessor :template, :path

    def initialize(attributes)
      self.path     = attributes[:path]
      self.template = Template.from_attributes(attributes[:template])
    end

    def serialize(attributes) 
      text = self.template.render(attributes)
      path = self.resource_path(attributes)

      Spectra.logger.debug "#{Spectra.options.dry_run ? 'would write' : 'writing'} to: #{path}" 

      if Spectra.options.dry_run
        Spectra.logger.debug "\n#{text}"
      else
        File.open(path, 'w+') { |file| file.write(text) }
      end
    end

    def resource_path(attributes)
      resource_path = self.path || self.template.path
      resource_path << '/' unless resource_path.end_with?('/')
      resource_path + self.template.filename
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

