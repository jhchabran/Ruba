class Snapshot
  include Observable
  
  attr_accessor :path, :name, :size, :litteral_size
  
  def initialize(opts={})
    opts.each do |k,v|
      send("#{k}=",v)
    end
  end
  
  def size=(amount)
    if amount.kind_of? String
      @litteral_size = amount
      @size = Bytes::Parser.read(amount)
    else
      @size = amount
    end
  end
  
  def cmd
    "sudo lvcreate --snapshot --size #{litteral_size} --name #{name} #{path}"
  end
  
  def take!
    changed
    notify_observers(cmd)
  end
end
