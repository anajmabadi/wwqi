require "spec_helper"

describe Admin::AppellationsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/appellations" }.should route_to(:controller => "admin/appellations", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/appellations/new" }.should route_to(:controller => "admin/appellations", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/appellations/1" }.should route_to(:controller => "admin/appellations", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/appellations/1/edit" }.should route_to(:controller => "admin/appellations", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/appellations" }.should route_to(:controller => "admin/appellations", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/appellations/1" }.should route_to(:controller => "admin/appellations", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/appellations/1" }.should route_to(:controller => "admin/appellations", :action => "destroy", :id => "1")
    end

  end
end
