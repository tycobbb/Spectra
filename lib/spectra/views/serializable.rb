
module Spectra

  module Serializable

    attr_accessor :directory, :filename

    def serialize(attributes)
      text = self.render(attributes)
      path = self.destination(attributes)

      Spectra.logger.debug "#{Spectra.options.dry_run ? 'would write' : 'writing'} to: #{path}"
       
      if Spectra.options.dry_run
        Spectra.logger.debug "\n#{text}"
      else
        File.open(path, 'w+') { |file| file.write(text) }
      end
    end

    def destination(attributes)
      destination = self.directory
      destination << '/' unless destination.end_with?('/')
      destination + self.filename
    end

    def directory 
      @directory ||= './'
    end

  end

end

