require 'spec_helper'

describe "clips/new.html.erb" do
  before(:each) do
    assign(:clip, stub_model(Clip,
      :new_record? => true,
      :title => "MyString",
      :caption => "MyText",
      :item_id => 1,
      :clip_type_id => 1,
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders new clip form" do
    render

    response.should have_selector("form", :action => clips_path, :method => "post") do |form|
      form.should have_selector("input#clip_title", :name => "clip[title]")
      form.should have_selector("textarea#clip_caption", :name => "clip[caption]")
      form.should have_selector("input#clip_item_id", :name => "clip[item_id]")
      form.should have_selector("input#clip_clip_type_id", :name => "clip[clip_type_id]")
      form.should have_selector("input#clip_publish", :name => "clip[publish]")
      form.should have_selector("textarea#clip_notes", :name => "clip[notes]")
    end
  end
end
