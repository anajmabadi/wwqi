require 'spec_helper'

describe "classifications/new.html.erb" do
  before(:each) do
    assign(:classification, stub_model(Classification,
      :new_record? => true,
      :subject_id => 1,
      :item_id => 1,
      :publish => false,
      :position => 1,
      :notes => "MyText"
    ))
  end

  it "renders new classification form" do
    render

    response.should have_selector("form", :action => classifications_path, :method => "post") do |form|
      form.should have_selector("input#classification_subject_id", :name => "classification[subject_id]")
      form.should have_selector("input#classification_item_id", :name => "classification[item_id]")
      form.should have_selector("input#classification_publish", :name => "classification[publish]")
      form.should have_selector("input#classification_position", :name => "classification[position]")
      form.should have_selector("textarea#classification_notes", :name => "classification[notes]")
    end
  end
end
