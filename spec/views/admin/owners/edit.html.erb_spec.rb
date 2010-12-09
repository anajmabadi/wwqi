require 'spec_helper'

describe "owners/edit.html.erb" do
  before(:each) do
    assign(:owner, @owner = stub_model(Owner,
      :new_record? => false,
      :name => "MyString",
      :address => "MyString",
      :address2 => "MyString",
      :state_province => "MyString",
      :postal_code => "MyString",
      :country => "MyString",
      :telephone => "MyString",
      :email => "MyString",
      :url => "MyString",
      :contact => "MyString",
      :terms => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders the edit owner form" do
    render

    response.should have_selector("form", :action => admin_owner_path(@owner), :method => "post") do |form|
      form.should have_selector("input#owner_name", :name => "owner[name]")
      form.should have_selector("input#owner_address", :name => "owner[address]")
      form.should have_selector("input#owner_address2", :name => "owner[address2]")
      form.should have_selector("input#owner_state_province", :name => "owner[state_province]")
      form.should have_selector("input#owner_postal_code", :name => "owner[postal_code]")
      form.should have_selector("input#owner_country", :name => "owner[country]")
      form.should have_selector("input#owner_telephone", :name => "owner[telephone]")
      form.should have_selector("input#owner_email", :name => "owner[email]")
      form.should have_selector("input#owner_url", :name => "owner[url]")
      form.should have_selector("input#owner_contact", :name => "owner[contact]")
      form.should have_selector("textarea#owner_terms", :name => "owner[terms]")
      form.should have_selector("textarea#owner_notes", :name => "owner[notes]")
    end
  end
end
