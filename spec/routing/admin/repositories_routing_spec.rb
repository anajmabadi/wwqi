require "spec_helper"

describe Admin::RepositoriesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/repositories" }.should route_to(:controller => "admin/repositories", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/repositories/new" }.should route_to(:controller => "admin/repositories", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/repositories/1" }.should route_to(:controller => "admin/repositories", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/repositories/1/edit" }.should route_to(:controller => "admin/repositories", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/repositories" }.should route_to(:controller => "admin/repositories", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/repositories/1" }.should route_to(:controller => "admin/repositories", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/repositories/1" }.should route_to(:controller => "admin/repositories", :action => "destroy", :id => "1")
    end

  end
end
