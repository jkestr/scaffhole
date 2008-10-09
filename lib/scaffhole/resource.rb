require 'actions'

module Scaffhole
  module Resource
    def self.included(base)
      base.cattr_accessor :klass
      base.cattr_accessor :scaffhole_options
      base.send(:include, Scaffhole::Actions)
      base.send(:append_view_path, File.join(File.dirname(__FILE__), '..', '..', 'views'))
    end
    
    def klass
      self.class.klass
    end
  end
end