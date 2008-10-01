require File.dirname(__FILE__) + '/spec_helper.rb'

ApplicationController.scaffhole :dummy

describe DummiesController, "index" do
  before(:each) do
    @controller = DummiesController.new
  end
  
  it "should load all dummies" do
    dummies = stub("dummies")
    Dummy.should_receive(:find).with(:all).and_return(dummies)
    get :index
    assigns(:dummies).should == dummies
  end
end