require "spec_helper"

describe AlternateTitlesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/alternate_titles" }.should route_to(:controller => "alternate_titles", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/alternate_titles/new" }.should route_to(:controller => "alternate_titles", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/alternate_titles/1" }.should route_to(:controller => "alternate_titles", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/alternate_titles/1/edit" }.should route_to(:controller => "alternate_titles", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/alternate_titles" }.should route_to(:controller => "alternate_titles", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/alternate_titles/1" }.should route_to(:controller => "alternate_titles", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/alternate_titles/1" }.should route_to(:controller => "alternate_titles", :action => "destroy", :id => "1")
    end

  end
end
