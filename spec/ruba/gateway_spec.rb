require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Gateways" do
  before(:each) do
    @observer = PretendObserver.new(@string_io = StringIO.new("","w"))
  end
  
  it "should respond to :warp!" do
    Gateway.new.should respond_to :warp!
  end
  
  describe ScpGateway do
    it "should create a scp gateway" do
      ScpGateway.new(:host => 'localhost')
    end
    
    describe "taking action" do
      before(:each) do
        @scp_gateway = ScpGateway.new(:host => 'localhost', :port => '2222', :user => 'lolcat')
        @observer << @scp_gateway
        
        @scp_gateway.warp! "cupcake"
        @cmd = @string_io.string
      end

      it "should include the command scp" do
        @cmd.should include("scp")
      end
      
      it "should include host" do
        @cmd.should include('localhost')
      end
      
      it "should include the port" do
        @cmd.should include("-p 2222")
      end
      
      it "should include the user" do
        @cmd.should include("lolcat")
      end
      
    end
  end
end