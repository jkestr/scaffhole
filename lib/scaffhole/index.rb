module Scaffhole
  module Index
    def index
      @collection = klass.find(:all)
      render :template => 'index.html.erb'
    end
  end
end