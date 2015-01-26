
module Spectra

module Serializable

  attr_accessor :directory, :filename

  def serialize(attributes)
    text = self.render(attributes)
    path = self.destination(attributes)

    begin
      file = File.open(path, 'w+')
    rescue Exception  
      raise Informative, "Couldn't open #{path}"
    else
      self.write_file(file, text, path)
    ensure
      file.close unless file.nil?
    end
  end

  def write_file(file, text, path)
    Spectra.logger.info "[✓] Generating #{path}"
    if Config.dry_run
      Spectra.logger.info "\n#{text.chomp}"
    else
      file.write(text)
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

end # module

