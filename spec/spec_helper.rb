$LOAD_PATH << File.dirname(__FILE__)
$LOAD_PATH << File.join(File.dirname(__FILE__), 'fixtures')
$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

require 'rubygems'
require 'abstract_active_record'
require 'actionpack'
require 'action_controller'
require 'application_controller'
require 'action_controller/test_process'

require 'scaffhole.rb'

require 'spec'
require 'spec/rails'

# This is here to allow you to integrate views on all of your controller specs
Spec::Runner.configuration.before(:all, :behaviour_type => :controller) do
  @integrate_views = true
end

def setup_controller
  ActionController::Routing::Routes.draw do |map|
    map.resources :dummies
  end
  
  @controller_class = DummiesController
  raise "Can't determine controller class for #{@controller_class_name}" if @controller_class.nil?

  @controller = @controller_class.new
  @request = ActionController::TestRequest.new
  @response = ActionController::TestResponse.new
  @response.session = @request.session
end

