require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Snapshot do
  it "should create a snapshot ready to be applied" do
    Snapshot.new(:size => "4G", :path => '/dev/vg00/pwet-disk', :name => 'pwet')
  end
  
  it "should store sizes as bytes" do
    Snapshot.new(:size => '50GB').size.should == 50.gigabytes
  end
end