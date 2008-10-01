require File.dirname(__FILE__) + '/spec_helper.rb'

ApplicationController.scaffhole :dummy

describe DummiesController, "index" do  
  def do_get
    get :index
  end
  
  before(:all) do
    setup_controller
    @dummy = Dummy.create! :name => 'Hummy', :age => 22
  end
  
  it "should be success" do
    do_get
    response.should be_success
  end
  
  it "should render index template" do
    do_get
    response.should render_template('index.html.erb')
  end
  
  describe "loading data" do
    it "should load @collection" do
      dummies = [@dummy]
      Dummy.should_receive(:find).with(:all).and_return(dummies)
      do_get
      assigns(:collection).should == dummies
    end
  end
end