require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Snapshot do
  before(:each) do
    @observer = PretendObserver.new(@string_io = StringIO.new("","w"))
  end
  
  it "should create a snapshot ready to be applied" do
    Snapshot.new(:size => "4G", :path => '/dev/vg00/pwet-disk', :name => 'pwet')
  end
  
  it "should store sizes as bytes" do
    Snapshot.new(:size => '50GB').size.should == 50.gigabytes
  end
  
  describe "taking action" do
    before(:each) do
      @snapshot = Snapshot.new(:size => "4G", :path => '/dev/vg00/pwet-disk', :name => 'pwet')
      @observer << @snapshot
    end
    
    describe "creating snapshot" do
      before(:each) do
        @snapshot.take!
        @cmd = @string_io.string
      end
      
      it "should use the command 'lvcreate" do
        @cmd.should include('lvcreate')
      end
    
      it "should specify a size" do
        @cmd.should include('--size 4G')
      end
    
      it "should specify a name" do
        @cmd.should include('--name pwet')
      end
    
      it "should specify a path" do
        @cmd.should include('/dev/vg00/pwet-disk')
      end
    end
    
    describe "removing a snapshot" do
      before(:each) do
        @snapshot.remove!
        @cmd = @string_io.string
      end
      it "should use the commande 'lvremove'" do
        @cmd.should include('lvremove')
      end
      
      it "should specify a path " do
        @cmd.should include('/dev/vg00/pwet-disk')
      end
    end
  end
  
end