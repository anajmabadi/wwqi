require "spec_helper"

describe Admin::ErasController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/eras" }.should route_to(:controller => "admin/eras", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/eras/new" }.should route_to(:controller => "admin/eras", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/eras/1" }.should route_to(:controller => "admin/eras", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/eras/1/edit" }.should route_to(:controller => "admin/eras", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/eras" }.should route_to(:controller => "admin/eras", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/eras/1" }.should route_to(:controller => "admin/eras", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/eras/1" }.should route_to(:controller => "admin/eras", :action => "destroy", :id => "1")
    end

  end
end
