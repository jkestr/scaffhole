module Scaffhole
  module Actions
    def self.included(base)
      base.extend(ClassMethods)
      
      base.add_action :index do
        begin
          @collection = klass.paginate(:all, :page => params[:page], :per_page => 50)
        rescue
          @collection = klass.find(:all)
        end
        
        respond_to do |format|
          format.html { render :template => 'index.html.erb' }
          format.xml  { render :xml  => @collection }
          format.json { render :json => @collection }
        end
      end
      
      base.add_action :new do
        @resource = klass.new(params[klass.class_name.to_sym])
        
        respond_to do |format|
          format.html { render :template => 'new.html.erb' }
          format.xml  { render :xml  => @resource }
          format.json { render :json => @resource }
        end
      end
      
      base.add_action :show do
        @resource = klass.find(params[:id])
        
        respond_to do |format|
          format.html { render :template => 'show.html.erb' }
          format.xml  { render :xml  => @resource }
          format.json { render :json => @resource }
        end
      end
      
      base.add_action :edit do
        @resource = klass.find(params[:id])
        
        respond_to do |format|
          format.html { render :template => 'edit.html.erb' }
        end
      end
      
      base.add_action :create do
        @resource = klass.new(params[klass.name.downcase.to_sym])
        
        respond_to do |format|
          if @resource.save
            flash[:notice] = 'Record was successfully created.'
            format.html { redirect_to(@resource) }
            format.xml  { render :xml  => @resource, :status => :created, :location => @resource }
            format.json { render :json => @resource, :status => :created, :location => @resource }
          else
            flash[:error] = 'Unable to create the record.'
            format.html { render :template => 'new.html.erb' }
            format.xml  { render :xml  => @resource.errors, :status => :unprocessable_entity }
            format.json { render :json => @resource.errors, :status => :unprocessable_entity }
          end
        end
      end
      
      base.add_action :update do
        @resource = klass.find(params[:id])
        
        respond_to do |format|
          if @resource.update_attributes(params[klass.name.downcase.to_sym])
            flash[:notice] = 'Record was successfully updated.'
            format.html { redirect_to(@resource) }
            format.xml  { head :ok }
            format.json { head :ok }
          else
            flash[:error] = 'Record could not be updated.'
            format.html { render :template => 'edit.html.erb' }
            format.xml  { render :xml  => @resource.errors, :status => :unprocessable_entity }
            format.json { render :json => @resource.errors, :status => :unprocessable_entity }
          end
        end
      end
      
      base.add_action :destroy do
        @resource = klass.find(params[:id])
        @resource.destroy
        
        flash[:notice] = 'Successfully removed the record.'
        respond_to do |format|
          format.html { redirect_to({:action => :index}) }
          format.xml  { head :ok }
          format.json { head :ok }
        end
      end
          
    end
    
    module ClassMethods
      def add_action(name, &block)
        define_method(name, &block)
      end
    end
  end
end