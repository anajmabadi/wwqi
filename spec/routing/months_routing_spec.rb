require "spec_helper"

describe MonthsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/months" }.should route_to(:controller => "months", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/months/new" }.should route_to(:controller => "months", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/months/1" }.should route_to(:controller => "months", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/months/1/edit" }.should route_to(:controller => "months", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/months" }.should route_to(:controller => "months", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/months/1" }.should route_to(:controller => "months", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/months/1" }.should route_to(:controller => "months", :action => "destroy", :id => "1")
    end

  end
end
