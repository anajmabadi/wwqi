require 'spec_helper'

describe "periods/new.html.erb" do
  before(:each) do
    assign(:period, stub_model(Period,
      :new_record? => true,
      :title => "MyString",
      :caption => "MyString",
      :description => "MyText",
      :position => 1,
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders new period form" do
    render

    response.should have_selector("form", :action => periods_path, :method => "post") do |form|
      form.should have_selector("input#period_title", :name => "period[title]")
      form.should have_selector("input#period_caption", :name => "period[caption]")
      form.should have_selector("textarea#period_description", :name => "period[description]")
      form.should have_selector("input#period_position", :name => "period[position]")
      form.should have_selector("input#period_publish", :name => "period[publish]")
      form.should have_selector("textarea#period_notes", :name => "period[notes]")
    end
  end
end
