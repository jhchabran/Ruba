class PretendObserver < CommandObserver
  def initialize io, *targets
    @io = io
    super *targets
  end
  
  def update cmd
    @io.write(cmd + "\n")
  end
end