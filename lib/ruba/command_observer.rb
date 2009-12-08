class CommandObserver 
  attr_accessor :targets
  
  def initialize *targets
    @targets = targets
    @targets.each { |target| target.add_observer(self) }
  end
  
  def << target
    @targets << target
    target.add_observer self
    self
  end
  
  def update cmd
    raise "Not implemented, can't run '#{cmd}'"
  end
end