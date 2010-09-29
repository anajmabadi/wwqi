require 'spec_helper'

describe "passports/new.html.erb" do
  before(:each) do
    assign(:passport, stub_model(Passport,
      :new_record? => true,
      :tag => "MyString",
      :owner_id => 1,
      :item_id => 1,
      :publish => false,
      :primary => false,
      :position => 1,
      :notes => "MyText",
      :custom_url => "MyString"
    ))
  end

  it "renders new passport form" do
    render

    rendered.should have_selector("form", :action => admin_passport_path, :method => "post") do |form|
      form.should have_selector("input#passport_tag", :name => "passport[tag]")
      form.should have_selector("input#passport_owner_id", :name => "passport[owner_id]")
      form.should have_selector("input#passport_item_id", :name => "passport[item_id]")
      form.should have_selector("input#passport_publish", :name => "passport[publish]")
      form.should have_selector("input#passport_primary", :name => "passport[primary]")
      form.should have_selector("input#passport_position", :name => "passport[position]")
      form.should have_selector("textarea#passport_notes", :name => "passport[notes]")
      form.should have_selector("input#passport_custom_url", :name => "passport[custom_url]")
    end
  end
end
