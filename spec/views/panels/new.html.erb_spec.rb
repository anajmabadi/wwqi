require 'spec_helper'

describe "panels/new.html.erb" do
  before(:each) do
    assign(:panel, stub_model(Panel,
      :new_record? => true,
      :exhibition_id => 1,
      :item_id => 1,
      :position => 1,
      :publish => false,
      :caption => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders new panel form" do
    render

    response.should have_selector("form", :action => admin_panels_path, :method => "post") do |form|
      form.should have_selector("input#panel_exhibition_id", :name => "panel[exhibition_id]")
      form.should have_selector("input#panel_item_id", :name => "panel[item_id]")
      form.should have_selector("input#panel_position", :name => "panel[position]")
      form.should have_selector("input#panel_publish", :name => "panel[publish]")
      form.should have_selector("textarea#panel_caption", :name => "panel[caption]")
      form.should have_selector("textarea#panel_notes", :name => "panel[notes]")
    end
  end
end
