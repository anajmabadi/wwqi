require "spec_helper"

describe Admin::AppellationsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin_appellations" }.should route_to(:controller => "admin_appellations", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin_appellations/new" }.should route_to(:controller => "admin_appellations", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin_appellations/1" }.should route_to(:controller => "admin_appellations", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin_appellations/1/edit" }.should route_to(:controller => "admin_appellations", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin_appellations" }.should route_to(:controller => "admin_appellations", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin_appellations/1" }.should route_to(:controller => "admin_appellations", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin_appellations/1" }.should route_to(:controller => "admin_appellations", :action => "destroy", :id => "1")
    end

  end
end
