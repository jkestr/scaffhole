module Scaffhole
  module Resource
    def self.included(base)
      base.cattr_accessor :klass
    end
  end
end