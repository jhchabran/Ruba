class Gateway
  include Observable
  
  def warp! path
    changed
    notify_observers cmd(path)
  end
  
  def cmd path
    raise "Not implemented"
  end
end

class CeilingCatGateway < Gateway
  def cmd path
    "echo 'MEOW #{path}'"
  end
end