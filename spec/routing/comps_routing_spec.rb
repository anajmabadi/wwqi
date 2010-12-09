require "spec_helper"

describe CompsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/comps" }.should route_to(:controller => "comps", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/comps/new" }.should route_to(:controller => "comps", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/comps/1" }.should route_to(:controller => "comps", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/comps/1/edit" }.should route_to(:controller => "comps", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/comps" }.should route_to(:controller => "comps", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/comps/1" }.should route_to(:controller => "comps", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/comps/1" }.should route_to(:controller => "comps", :action => "destroy", :id => "1")
    end

  end
end
