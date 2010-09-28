require 'spec_helper'

describe "exhibitions/edit.html.erb" do
  before(:each) do
    assign(:exhibition, @exhibition = stub_model(Exhibition,
      :new_record? => false,
      :title => "MyString",
      :caption => "MyString",
      :introduction => "MyText",
      :conclusion => "MyText",
      :author => "MyString",
      :featured => false,
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders the edit exhibition form" do
    render

    response.should have_selector("form", :action => admin_exhibition_path(@exhibition), :method => "post") do |form|
      form.should have_selector("input#exhibition_title", :name => "exhibition[title]")
      form.should have_selector("input#exhibition_caption", :name => "exhibition[caption]")
      form.should have_selector("textarea#exhibition_introduction", :name => "exhibition[introduction]")
      form.should have_selector("textarea#exhibition_conclusion", :name => "exhibition[conclusion]")
      form.should have_selector("input#exhibition_author", :name => "exhibition[author]")
      form.should have_selector("input#exhibition_featured", :name => "exhibition[featured]")
      form.should have_selector("input#exhibition_publish", :name => "exhibition[publish]")
      form.should have_selector("textarea#exhibition_notes", :name => "exhibition[notes]")
    end
  end
end
