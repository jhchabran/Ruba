class Image
  include Observable
  
  attr_accessor :input_file, :output_file
  
  def initialize(opts={})
    assigns_options opts
  end
  
  def copy_cmd
    "sudo dd if=#{input_file} of=#{output_file} bs=64k"
  end
  
  def copy!
    changed
    notify_observers(copy_cmd)
  end
end