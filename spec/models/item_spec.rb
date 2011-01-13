# coding: utf-8
require 'spec_helper'

describe Item do
  
  before(:each) do
    @item = Item.new
    @sample_attributes = {
      :title_en => "Sample title",
      :title_fa => "Sample farsi title",
      :published_en => "My pub details",
      :published_fa => "Still pub details but in farsi",
      :pages => 2,
      :accession_num => "ABCD-00011",
      :width => 23.4,
      :height => 19.2,
      :depth => 2.3,
      :urn => 'test',
      :owner_id => 1,
      :collection_id => 2,
      :format_id => 1,
      :circa => false,
      :notes => 'String',
      :bound => true,
      :publish => true,
      :source_date => '12 May 1920',
      :calendar_type_id => 1,
      :favorite => true,
      :year => 1233,
      :month => 12,
      :day => 23,
      :editorial_dating => true,
      :era_id => 1,
      :sort_year => 2222,
      :sort_day => 22,
      :sort_month => 12,
      :owner_tag_en => 'hello',
      :owner_tag_fa => 'hello'
    }
  end

  it "should be valid" do
    @item.update_attributes(@sample_attributes)
    @item.should be_valid
  end
  
  it "should require an accession num" do
    @sample_attributes[:accession_num] = nil
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
  
  it "should require pages" do
    @sample_attributes[:pages] = nil
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
  
  it "should require circa" do
    @sample_attributes[:circa] = nil
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
  
  it "should require bound" do
    @sample_attributes[:bound] = nil
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
  
  it "should require publish" do
    @sample_attributes[:publish] = nil
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
  
  it "should require favorite" do
    @sample_attributes[:favorite] = nil
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
  
  it "should require editorial_date" do
    @sample_attributes[:editorial_date] = nil
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
  
  it "should require a numeric pages" do
    @sample_attributes[:pages] = "should be a number"
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
  
  it "should require pages between 1 and 10000" do
    @sample_attributes[:pages] = 0
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
    @sample_attributes[:pages] = 10001
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
    @sample_attributes[:pages] = -100
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid  
  end
  
  it "should require width" do
    @sample_attributes[:width] = nil
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
    
  it "should require height" do
    @sample_attributes[:height] = nil
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end  
  
  it "should require depth" do
    @sample_attributes[:depth] = nil
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
  
  # testing the file accessors from the library
  
  it "should return a valid tif file name for a page" do
    @item.update_attributes(@sample_attributes)
    @item.tif_file_name(1).should == "it_#{@item.id.to_s}_1.tif"
  end
  
  it "should return a valid tif url for a page" do
    @item.update_attributes(@sample_attributes)
    @item.tif_url(1).should == "http://library.qajarwomen.org/tifs/it_#{@item.id.to_s}_1.tif"
  end  
  
  it "should return a valid set of tif urls" do
    @item.update_attributes(@sample_attributes)
    @item.tif_urls.should == ["http://library.qajarwomen.org/tifs/it_#{@item.id.to_s}_1.tif","http://library.qajarwomen.org/tifs/it_#{@item.id.to_s}_2.tif" ]
  end    
  
  it "should return a valid preview file name for a page" do
    @item.update_attributes(@sample_attributes)
    @item.preview_file_name(1).should == "it_#{@item.id.to_s}_1.jpg"
  end
  
  it "should return a valid preview url for a page" do
    @item.update_attributes(@sample_attributes)
    @item.preview_url(1).should == "http://library.qajarwomen.org/previews/it_#{@item.id.to_s}_1.jpg"
  end
  
  it "should return a valid set of preview urls" do
    @item.update_attributes(@sample_attributes)
    @item.preview_urls.should == ["http://library.qajarwomen.org/previews/it_#{@item.id.to_s}_1.jpg","http://library.qajarwomen.org/previews/it_#{@item.id.to_s}_2.jpg" ]
  end
  
  it "should return a valid thumbnail file name" do
    @item.update_attributes(@sample_attributes)
    @item.thumbnail_file_name.should == "it_#{@item.id.to_s}.jpg"
  end
  
  it "should return a valid thumbnail url" do
    @item.update_attributes(@sample_attributes)
    @item.thumbnail_url.should == "http://library.qajarwomen.org/thumbs/it_#{@item.id.to_s}.jpg"
  end
  
  it "should return a valid zoomify folder name for a page" do
    @item.update_attributes(@sample_attributes)
    @item.zoomify_folder_name(1).should == "it_#{@item.id.to_s}_1_img"
  end
  
  it "should return a valid zoomify url for a page" do
    @item.update_attributes(@sample_attributes)
    @item.zoomify_url(1).should == "http://library.qajarwomen.org/zoomify/it_#{@item.id.to_s}_1_img"
  end
  
  it "should not allow duplicate persons and items" do  
    @item.update_attributes(@sample_attributes)
    @item.should be_valid
    @item2 = Item.new(@sample_attributes)
    @item2.should_not be_valid
  end
end