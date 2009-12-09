class Gateway
  include Observable
  
  def warp! path
    changed
    notify_observers(cmd(path))
  end
  
  def cmd path
    raise "Not implemented"
  end
end

class CeilingCatGateway < Gateway
  def cmd path
    "sudo lolcat #{path} /dev/ceiling_cat"
  end
end

class ScpGateway < Gateway
  attr_accessor :uri
  
  def initialize(uri)
    @uri = URI.parse(uri)
  end
  
  def cmd(path)
    command = "sudo "
    command << "scp "
    command << path << " "
    command << @uri.user << "@" if @uri.user
    command << @uri.host << ":"<< @uri.path
    command << "-p " << @uri.port.to_s << " " if @uri.port
    command
  end
end