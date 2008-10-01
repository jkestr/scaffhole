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
        klass = klass_name.constantize rescue begin
          Object.const_set(klass_name, Class.new(self))
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
