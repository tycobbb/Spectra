
require 'logger'

class SpectraLogger < Logger
  
  def terminate(message)
    self.fatal(message)
    exit
  end

end

