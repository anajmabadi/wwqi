require "spec_helper"

describe Admin::CompsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/comps" }.should route_to(:controller => "admin/comps", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/comps/new" }.should route_to(:controller => "admin/comps", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/comps/1" }.should route_to(:controller => "admin/comps", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/comps/1/edit" }.should route_to(:controller => "admin/comps", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/comps" }.should route_to(:controller => "admin/comps", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/comps/1" }.should route_to(:controller => "admin/comps", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/comps/1" }.should route_to(:controller => "admin/comps", :action => "destroy", :id => "1")
    end

  end
end
