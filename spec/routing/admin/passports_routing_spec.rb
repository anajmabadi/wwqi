require "spec_helper"

describe Admin::PassportsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/passports" }.should route_to(:controller => "admin/passports", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/passports/new" }.should route_to(:controller => "admin/passports", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/passports/1" }.should route_to(:controller => "admin/passports", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/passports/1/edit" }.should route_to(:controller => "admin/passports", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/passports" }.should route_to(:controller => "admin/passports", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/passports/1" }.should route_to(:controller => "admin/passports", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/passports/1" }.should route_to(:controller => "admin/passports", :action => "destroy", :id => "1")
    end

  end
end
