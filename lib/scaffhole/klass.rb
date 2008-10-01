ActionController::Base.class_eval do
  
  def self.scaffhole(name)
    klass = Class.new(ApplicationController)
    klass.send(:include, Scaffhole::Resource)
    klass.klass = name.to_s.classify.constantize
    klass_name = "#{name.to_s.pluralize}_controller"
    Object.const_set klass_name.classify, klass
  end
  
end