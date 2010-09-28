require 'spec_helper'

describe "collections/edit.html.erb" do
  before(:each) do
    assign(:collection, @collection = stub_model(Collection,
      :new_record? => false,
      :name => "MyString",
      :address => "MyString",
      :address2 => "MyString",
      :city => "MyString",
      :state_province => "MyString",
      :postal_code => "MyString",
      :telephone => "MyString",
      :email => "MyString",
      :website => "MyString",
      :contact => "MyString",
      :notes => "MyText"
    ))
  end

  it "renders the edit collection form" do
    render

    response.should have_selector("form", :action => admin_collection_path(@collection), :method => "post") do |form|
      form.should have_selector("input#collection_name", :name => "collection[name]")
      form.should have_selector("input#collection_address", :name => "collection[address]")
      form.should have_selector("input#collection_address2", :name => "collection[address2]")
      form.should have_selector("input#collection_city", :name => "collection[city]")
      form.should have_selector("input#collection_state_province", :name => "collection[state_province]")
      form.should have_selector("input#collection_postal_code", :name => "collection[postal_code]")
      form.should have_selector("input#collection_telephone", :name => "collection[telephone]")
      form.should have_selector("input#collection_email", :name => "collection[email]")
      form.should have_selector("input#collection_website", :name => "collection[website]")
      form.should have_selector("input#collection_contact", :name => "collection[contact]")
      form.should have_selector("textarea#collection_notes", :name => "collection[notes]")
    end
  end
end
