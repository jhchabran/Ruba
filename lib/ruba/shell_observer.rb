class ShellObserver < CommandObserver
  def update cmd
    system cmd
  end
end