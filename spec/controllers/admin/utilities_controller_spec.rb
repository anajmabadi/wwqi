require 'spec_helper'

describe Admin::UtilitiesController do

  def mock_image(stubs={})
    @mock_image ||= mock_model(Image, :file_name => "test.tif").as_null_object
  end
  
  def mock_item(stubs={})
    @mock_item ||= mock_model(Item, :collection_id => 12).as_null_object
  end
  
  describe "GET index" do
    it "assigns all utilities as @utilities" do
      get :index
    end
  end

  describe "rename_by_file_name" do
    it "names a group of files by their original file name" do
      Image.stub(:all) { [mock_image, mock_image] }
      mock_image.stub(:tif_file_name) { "it_1.tif" }
      get :rename_by_file_name
      assigns(:images).should eq([mock_image, mock_image])
      assigns(:failed).should be_false
      assigns(:processed_count).should == assigns(:images).count
    end
  end
  
  describe "rename_thumbs_by_index" do
    it "renames a sequential series of thumbnail images for a sorted collection of items" do
      # stub out the find by collection id
      Item.should_receive(:find).with(:all, :conditions => ["collection_id = :collection_id", {:collection_id => 12}], :order => "accession_num").and_return([mock_item])
      #make the call with the right params
      get :rename_thumbs_by_index, :collection_id => 12
      # should get some items
      assigns(:items).should eq([mock_item])
      # should succeed
      assigns(:failed).should be_false
      # we need to add 1 because thumb sequences start at 1 and not 0
      assigns(:processed_count).should == assigns(:items).count + 1
    end
  end
end
