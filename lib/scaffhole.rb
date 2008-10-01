$LOAD_PATH << File.join(File.dirname(__FILE__), 'scaffhole')

require 'resource'
require 'index'
require 'klass'

ActionController::Base.send :include, Scaffhole::Klass