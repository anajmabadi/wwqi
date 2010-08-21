# coding: utf-8
require 'spec_helper'

describe Item do
  fixtures :translations
  
  before(:each) do
    @item = Item.new
    @sample_attributes = {
      :title => "Sample title",
      :pages => 2,
      :accession_num => "ABCD-00011",
      :width => 23.4,
      :height => 19.2
    }
  end

  it "should be valid" do
    @item.update_attributes(@sample_attributes)
    @item.should be_valid
  end
  
  it "should require a title" do
    @sample_attributes[:title] = nil
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
  
  it "should require a title longer than 2 characters and shorter than 255 characters" do
    @sample_attributes[:title] = "12"
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
    @sample_attributes[:title] = 'a' * 256
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
  
  it "should require an accession_num" do
    @sample_attributes[:accession_num] = nil
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
  
  it "should require an accession_num longer than 2 characters and shorter than 255 characters" do
    @sample_attributes[:accession_num] = "12"
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
    @sample_attributes[:accession_num] = 'a' * 256
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
  
  it "should require pages" do
    @sample_attributes[:pages] = nil
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
  
  it "should return a valid dimensions string in English" do
    old_locale = I18n.locale
    I18n.locale = :en
    @item.update_attributes(@sample_attributes)
    @item.dimension_label.should == "23.4 x 19.2 cm"
    I18n.locale = old_locale
  end

  it "should return a valid dimensions string in Persian" do
    old_locale = I18n.locale
    I18n.locale = :fa
    @item.update_attributes(@sample_attributes)
    @item.dimension_label.should == "۲۳.۴ * ۱۹.۲ سانتیمتر"
    I18n.locale = old_locale
  end
end