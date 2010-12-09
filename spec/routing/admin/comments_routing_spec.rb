require "spec_helper"

describe Admin::CommentsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/comments" }.should route_to(:controller => "admin/comments", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/comments/new" }.should route_to(:controller => "admin/comments", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/comments/1" }.should route_to(:controller => "admin/comments", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/comments/1/edit" }.should route_to(:controller => "admin/comments", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/comments" }.should route_to(:controller => "admin/comments", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/comments/1" }.should route_to(:controller => "admin/comments", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/comments/1" }.should route_to(:controller => "admin/comments", :action => "destroy", :id => "1")
    end

  end
end
