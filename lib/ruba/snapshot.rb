class Snapshot
  include Observable
  
  attr_accessor :path, :name, :size, :litteral_size
  
  def initialize(opts={})
    assigns_options opts
  end
  
  def size=(amount)
    if amount.kind_of? String
      @litteral_size = amount
      @size = Bytes::Parser.read(amount)
    else
      @size = amount
    end
  end
  
  def take_cmd
    "sudo lvcreate --snapshot --size #{litteral_size} --name #{name} #{path}"
  end
  
  def remove_cmd
    "sudo lvremove #{directory_path}/#{name}"
  end
  
  def take!
    changed
    notify_observers(take_cmd)
  end
  
  def remove!
    changed
    notify_observers(remove_cmd)
  end
  
  private
  def directory_path
    path.match(/(.*)\/[^\/]*$/)
    $1
  end
end
