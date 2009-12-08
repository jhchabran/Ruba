class Snapshot
  attr_accessor :path, :name, :size
  
  def initialize(opts={})
    opts.each do |k,v|
      send("#{k}=",v)
    end
  end
  
  def size=(amount)
    
  end
end
