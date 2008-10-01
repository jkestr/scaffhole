module Scaffhole
  module Actions
    def self.included(base)
      base.extend(ClassMethods)
      
      base.add_action :index do
        @collection = klass.find(:all)
        render :template => 'index.html.erb'
      end
    end
    
    module ClassMethods
      def add_action(name, &block)
        define_method(name, &block)
      end
    end
  end
end