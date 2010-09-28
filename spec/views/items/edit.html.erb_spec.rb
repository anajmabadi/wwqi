require 'spec_helper'

describe "items/edit.html.erb" do
  before(:each) do
    assign(:item, @item = stub_model(Item,
      :new_record? => false,
      :title => "MyString",
      :accession_num => "MyString",
      :caption => "MyString",
      :description => "MyText",
      :olivia_id => "MyString",
      :urn => "MyString",
      :creator_id => 1,
      :owner_id => 1,
      :collection_id => 1,
      :pages => 1,
      :format_id => 1,
      :display_date => "MyString",
      :dimensions => "MyString",
      :notes => "MyText",
      :place_id => 1,
      :publish => false
    ))
  end

  it "renders the edit item form" do
    render

    response.should have_selector("form", :action => admin_item_path(@item), :method => "post") do |form|
      form.should have_selector("input#item_title", :name => "item[title]")
      form.should have_selector("input#item_accession_num", :name => "item[accession_num]")
      form.should have_selector("input#item_caption", :name => "item[caption]")
      form.should have_selector("textarea#item_description", :name => "item[description]")
      form.should have_selector("input#item_olivia_id", :name => "item[olivia_id]")
      form.should have_selector("input#item_urn", :name => "item[urn]")
      form.should have_selector("input#item_creator_id", :name => "item[creator_id]")
      form.should have_selector("input#item_owner_id", :name => "item[owner_id]")
      form.should have_selector("input#item_collection_id", :name => "item[collection_id]")
      form.should have_selector("input#item_pages", :name => "item[pages]")
      form.should have_selector("input#item_format_id", :name => "item[format_id]")
      form.should have_selector("input#item_display_date", :name => "item[display_date]")
      form.should have_selector("input#item_dimensions", :name => "item[dimensions]")
      form.should have_selector("textarea#item_notes", :name => "item[notes]")
      form.should have_selector("input#item_place_id", :name => "item[place_id]")
      form.should have_selector("input#item_publish", :name => "item[publish]")
    end
  end
end
