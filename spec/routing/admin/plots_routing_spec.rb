require "spec_helper"

describe Admin::PlotsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/plots" }.should route_to(:controller => "admin/plots", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/plots/new" }.should route_to(:controller => "admin/plots", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/plots/1" }.should route_to(:controller => "admin/plots", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/plots/1/edit" }.should route_to(:controller => "admin/plots", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/plots" }.should route_to(:controller => "admin/plots", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/plots/1" }.should route_to(:controller => "admin/plots", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/plots/1" }.should route_to(:controller => "admin/plots", :action => "destroy", :id => "1")
    end

  end
end
