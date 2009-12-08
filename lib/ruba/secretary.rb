class Secretary
  def initialize(jobs)
    @jobs = jobs
  end
  
  def work
    @jobs.each do |job|
      job.run
    end
  end
end