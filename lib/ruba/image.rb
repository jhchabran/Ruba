class Image
  include Observable
  
  attr_accessor :input, :output
  
  def initialize(opts={})
    assigns_options opts
  end
  
  def copy_cmd
    "sudo dd if=#{input} of=#{output} bs=64k"
  end
  
  def copy!
    changed
    notify_observers(copy_cmd)
  end
end