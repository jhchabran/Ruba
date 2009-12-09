class Job
  attr_accessor :disk_path, :output_path, :observer, :gateway
  
  def initialize opts
    assigns_options opts
    @output_file = output_path + '/' + extract_name(disk_path) + '.img.bz2' # should not be handled here
    @observer << @gateway # TODO this line screams about something being wrong here
  end
  
  def run
    spawn_snapshot
    take_snapshot
    make_image
    transfer_image
    delete_image
  ensure
    destroy_snapshot
  end
  
  
  private
  
  def make_image
    @image = Image.new(:input_file => disk_path + '_backup', :output_file => @output_file )
    @observer << @image
    @image.copy!
  end
  
  def delete_image
    @image.delete!
  end
  
  def transfer_image
    @gateway.warp! @output_file
  end
  
  def spawn_snapshot
    @snapshot = Snapshot.new(:size => "5G", :path => disk_path, :name => extract_name(disk_path)+'_backup')
    @observer << @snapshot
  end
  
  def take_snapshot
    @snapshot.take!
  end
  
  def destroy_snapshot
    @snapshot.remove!
  end
  
  def extract_name(disk_path)
    disk_path.match(/.*\/([^\/]+)/)
    $1
  end
end