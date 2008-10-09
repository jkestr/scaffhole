$LOAD_PATH << File.join(File.dirname(__FILE__), 'scaffhole')

require 'resource'

ActionController::Base.class_eval do
  def self.scaffhole(name, options = {})
    klass_name = "#{name.to_s.pluralize}_controller".classify
    klass = klass_name.constantize rescue begin
      Object.const_set(klass_name, Class.new(self))
    end
    
    klass.send(:include, Scaffhole::Resource)
    klass.klass = name.to_s.classify.constantize
    klass.scaffhole_options = { 
      :list_columns => klass.klass.column_names, 
      :edit_columns => klass.klass.column_names,
      :show_columns => klass.klass.column_names
    }.merge(options)
    
  end
end