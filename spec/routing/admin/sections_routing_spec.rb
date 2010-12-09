require "spec_helper"

describe Admin::SectionsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/sections" }.should route_to(:controller => "admin/sections", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/sections/new" }.should route_to(:controller => "admin/sections", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/sections/1" }.should route_to(:controller => "admin/sections", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/sections/1/edit" }.should route_to(:controller => "admin/sections", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/sections" }.should route_to(:controller => "admin/sections", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/sections/1" }.should route_to(:controller => "admin/sections", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/sections/1" }.should route_to(:controller => "admin/sections", :action => "destroy", :id => "1")
    end

  end
end
