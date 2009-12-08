class Object
  def assigns_options opts
    opts.each do |k,v|
      send("#{k}=",v)
    end
  end
end