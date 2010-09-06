require "spec_helper"

describe PassportsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/passports" }.should route_to(:controller => "passports", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/passports/new" }.should route_to(:controller => "passports", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/passports/1" }.should route_to(:controller => "passports", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/passports/1/edit" }.should route_to(:controller => "passports", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/passports" }.should route_to(:controller => "passports", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/passports/1" }.should route_to(:controller => "passports", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/passports/1" }.should route_to(:controller => "passports", :action => "destroy", :id => "1")
    end

  end
end
