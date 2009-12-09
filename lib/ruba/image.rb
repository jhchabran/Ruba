class Image
  include Observable
  
  attr_accessor :input_file, :output_file
  
  def initialize(opts={})
    assigns_options opts
  end
  
  def copy_cmd
    "sudo dd if=#{input_file} bs=64k | bzip2 > #{output_file}"
  end
  
  def delete_cmd
    "sudo rm #{output_file}"
  end
  
  def compress_cmd
    "sudo "
  end
  
  def copy!
    changed
    notify_observers(copy_cmd)
  end
  
  def compress!
    changed
    notify_observers(compress_cmd)
  end
  
  def delete!
    changed
    notify_observers(delete_cmd)
  end
end