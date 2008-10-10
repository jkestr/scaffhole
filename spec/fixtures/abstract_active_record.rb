require 'active_record'

ROOT       = File.join(File.dirname(__FILE__), '..') unless defined?(ROOT)
RAILS_ROOT = ROOT unless defined?(RAILS_ROOT)

ENV['RAILS_ENV'] ||= 'test'

config = YAML::load_file(File.dirname(__FILE__) + '/database.yml')
ActiveRecord::Base.logger = Logger.new("/dev/null")
ActiveRecord::Base.establish_connection(config[ENV['RAILS_ENV'] || 'test'])

ActiveRecord::Base.connection.create_table :dummies, :force => true do |table|
  table.column :name, :string
  table.column :age, :integer
  table.column :created_at, :datetime
  table.column :updated_at, :datetime
end

class Dummy < ActiveRecord::Base
  validates_presence_of :name
end
