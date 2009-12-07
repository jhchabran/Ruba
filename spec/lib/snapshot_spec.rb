require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Snapshot do
  it "should create a snapshot ready to be applied" do
    Snapshot.new(:size => "4G", :path => '/dev/vg00/pwet-disk', :name => 'pwet')
  end
end