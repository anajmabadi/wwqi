require 'spec_helper'

describe "appearances/new.html.erb" do
  before(:each) do
    assign(:appearance, stub_model(Appearance,
      :new_record? => true,
      :item_id => 1,
      :person_id => 1,
      :publish => false,
      :position => 1,
      :caption => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders new appearance form" do
    render

    response.should have_selector("form", :action => admin_appearances_path, :method => "post") do |form|
      form.should have_selector("input#appearance_item_id", :name => "appearance[item_id]")
      form.should have_selector("input#appearance_person_id", :name => "appearance[person_id]")
      form.should have_selector("input#appearance_publish", :name => "appearance[publish]")
      form.should have_selector("input#appearance_position", :name => "appearance[position]")
      form.should have_selector("textarea#appearance_caption", :name => "appearance[caption]")
      form.should have_selector("textarea#appearance_notes", :name => "appearance[notes]")
    end
  end
end
