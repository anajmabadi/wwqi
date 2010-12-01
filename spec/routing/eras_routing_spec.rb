require "spec_helper"

describe ErasController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/eras" }.should route_to(:controller => "eras", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/eras/new" }.should route_to(:controller => "eras", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/eras/1" }.should route_to(:controller => "eras", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/eras/1/edit" }.should route_to(:controller => "eras", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/eras" }.should route_to(:controller => "eras", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/eras/1" }.should route_to(:controller => "eras", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/eras/1" }.should route_to(:controller => "eras", :action => "destroy", :id => "1")
    end

  end
end
