require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Bytes do
  describe "units" do
    it "should use byte as default unit" do
      1.should == 1.byte
    end
    
    it "a kilobyte should be equal to 1024 bytes" do
      1.kilobyte.should == 1024.bytes
    end

    it "a megabyte should be equal to 1024 kilobytes" do
      1.megabyte.should == 1024.kilobytes
    end

    it "a gigabyte should be equal to 1024 megabytes" do
      1.gigabyte.should == 1024.megabytes
    end

    it "a terabyte should be equal to 1024 gigabytes" do
      1.terabyte.should == 1024.gigabytes
    end
  end
  
  describe "parsing" do
    describe "success" do
      it "should parse '1B' as 1 byte" do
        Bytes::Parser.read("1B").should == 1.byte
      end

      it "should parse '1KB' as 1 kilobyte" do
        Bytes::Parser.read("1KB").should == 1.kilobyte
      end

      it "should parse '1324KB' as 1324 kilobyte" do
        Bytes::Parser.read("1324KB").should == 1324.kilobyte
      end

      it "should parse '1MB' as 1 megabyte" do
        Bytes::Parser.read("1MB").should == 1.megabyte
      end

      it "should parse '1GB' as 1 gigabyte" do
        Bytes::Parser.read("1GB").should == 1.gigabyte
      end

      it "should parse '1GB' as 1 gigabyte" do
        Bytes::Parser.read("1TB").should == 1.terabyte
      end
    end
    describe "failures" do
      (%w(1K 1Z 230b 1A2GB ZB 07Iz)+["10 1KB", "1KB KB"]).each do |input|
        it "should return nil when reading #{input}" do
          Bytes::Parser.read(input).should be_nil
        end
      end
    end
  end
end