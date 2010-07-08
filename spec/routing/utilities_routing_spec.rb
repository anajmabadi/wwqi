require "spec_helper"

describe UtilitiesController do
  describe "routing" do

        it "recognizes and generates #index" do
      { :get => "/utilities" }.should route_to(:controller => "utilities", :action => "index")
    end

        it "recognizes and generates #new" do
      { :get => "/utilities/new" }.should route_to(:controller => "utilities", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/utilities/1" }.should route_to(:controller => "utilities", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/utilities/1/edit" }.should route_to(:controller => "utilities", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/utilities" }.should route_to(:controller => "utilities", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/utilities/1" }.should route_to(:controller => "utilities", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/utilities/1" }.should route_to(:controller => "utilities", :action => "destroy", :id => "1") 
    end

  end
end
