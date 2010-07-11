require 'spec_helper'

describe UtilitiesController do

  def mock_image(stubs={})
    @mock_image ||= mock_model(Image, :file_name => "test.tif").as_null_object
  end

  describe "GET index" do
    it "assigns all utilities as @utilities" do
      get :index
    end
  end

  describe "GET rename_by_file_name" do
    it "assigns all utilities as @images" do
      Image.stub(:all) { [mock_image, mock_image] }
      mock_image.stub(:tif_file_name) { "it_1.tif" }
      get :rename_by_file_name
      assigns(:images).should eq([mock_image, mock_image])
      assigns(:base_dir).should == "/Volumes/passport/project_libraries/qajar\ archive/"
      assigns(:base_dir).should == "/Volumes/passport/project_libraries/qajar\ archive/"
      assigns(:input_dir).should == "_input/"
      assigns(:output_dir).should == "_output/"  
      assigns(:pub_tif_dir).should == "pub/tif/"
      assigns(:failed).should be_false
      assigns(:processed_count).should == assigns(:images).count
    end
  end
  
end
