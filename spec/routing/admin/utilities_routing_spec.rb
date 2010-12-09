require "spec_helper"

describe Admin::UtilitiesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/utilities" }.should route_to(:controller => "admin/utilities", :action => "index")
    end

    it "recognizes and generates #rename_by_file_name" do
      { :get => "/admin/utilities/rename_by_file_name" }.should route_to(:controller => "admin/utilities", :action => "rename_by_file_name")
    end

    it "recognizes and generates #rename_thumbs_by_index" do
      { :get => "/admin/utilities/rename_thumbs_by_index/1" }.should route_to(:controller => "admin/utilities", :action => "rename_thumbs_by_index", :collection_id => "1")
    end

  end
end
