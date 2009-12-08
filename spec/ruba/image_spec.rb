require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Image do
  before(:each) do
    @observer = PretendObserver.new(@string_io = StringIO.new("","w"))
  end
  
  it "should create an Image ready to copy" do
    Image.new(:input_file => '/dev/urandom', :output_file => '/tmp/image.iso')
  end
  
  describe "taking action" do
    before(:each) do
      @image = Image.new(:input_file => '/dev/urandom', :output_file => '/tmp/image.iso')
      @observer << @image
    end
    
    describe "copying" do
      before(:each) do
        @image.copy!
        @cmd = @string_io.string
      end
      
      it "should include the command dd" do
        @cmd.should include("dd")
      end
      
      it "should include the input file" do
        @cmd.should include("if=/dev/urandom")
      end
      
      it "should include the output file" do
        @cmd.should include("of=/tmp/image.iso")
      end
    end
  end
end