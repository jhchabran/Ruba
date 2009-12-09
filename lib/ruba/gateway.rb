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
    "sudo lolcat #{path} /dev/ceiling_cat"
  end
end