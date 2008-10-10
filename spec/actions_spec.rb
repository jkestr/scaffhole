require File.dirname(__FILE__) + '/spec_helper.rb'

ApplicationController.scaffhole :dummy

describe DummiesController do
  before(:all) do
    setup_controller
    @dummy = Dummy.create! :name => 'Hummy', :age => 22
  end

  describe "GET /dummies" do  
    def do_get
      get :index
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
  
  describe "GET /dummies/new" do
    def do_get
      get :new
    end
    
    it "is successful" do
      do_get
      response.should be_success
    end
    
    it "renders show template" do
      do_get
      response.should render_template('new.html.erb')
    end
  end
  
  describe "GET /dummies/1" do
    def do_get
      get :show, :id => @dummy.to_param
    end
    
    it "is successful" do
      do_get
      response.should be_success
      assigns(:resource).should == @dummy
    end
    
    it "renders show template" do
      do_get
      response.should render_template('show.html.erb')
    end
  end
  
  describe "GET /dummies/1/edit" do
    def do_get
      get :edit, :id => @dummy.to_param
    end
    
    it "is successful" do
      do_get
      response.should be_success
      assigns(:resource).should == @dummy
    end
    
    it "renders show template" do
      do_get
      response.should render_template('edit.html.erb')
    end
  end
  
  describe "PUT /dummies/1" do
    def do_put(options={})
      put :update, :id => @dummy.to_param, :dummy => { :name => 'new name!' }.merge(options)
    end
    
    describe "successfully updating" do
      it "should update dummy" do
        do_put
        @dummy.reload
        @dummy.name.should == 'new name!'
      end
      
      it "should redirect to dummy" do
        do_put
        response.should redirect_to(dummy_path(@dummy))
      end
    end

    describe "unsuccessfully updating" do
      it "should render edit page" do
        do_put :name => nil
        response.should render_template('edit.html.erb')
      end
    end
  end
end

