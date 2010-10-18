require "spec_helper"

describe PlotsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/plots" }.should route_to(:controller => "plots", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/plots/new" }.should route_to(:controller => "plots", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/plots/1" }.should route_to(:controller => "plots", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/plots/1/edit" }.should route_to(:controller => "plots", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/plots" }.should route_to(:controller => "plots", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/plots/1" }.should route_to(:controller => "plots", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/plots/1" }.should route_to(:controller => "plots", :action => "destroy", :id => "1")
    end

  end
end
