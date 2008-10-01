# Might want to move a lot of this stuff to Resource,
# just for naming's sake.
module Scaffhole
  module Klass
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
    end
    
    module ClassMethods
      def scaffhole(name)
        klass_name = "#{name.to_s.pluralize}_controller".classify
        if Object.const_defined?(klass_name)
          klass = klass_name.constantize
        else
          klass = Class.new(self)
          Object.const_set(klass_name, klass)
        end
        
        klass.send(:include, Scaffhole::Resource)
        klass.send(:include, Scaffhole::Index)
        klass.send(:append_view_path, File.join(File.dirname(__FILE__), '..', '..', 'views'))
        klass.klass = name.to_s.classify.constantize
      end
    end
    
    module InstanceMethods
      def klass
        self.class.klass
      end
    end
  end
end
