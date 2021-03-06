require File.dirname(__FILE__) + '/spec_helper.rb'

describe ApplicationController do
  it "should generate subclass" do
    ApplicationController.scaffhole :dummy
    DummiesController.superclass.should == ApplicationController
  end
  
  it "should have klass" do
    DummiesController.klass.should == Dummy
  end
end