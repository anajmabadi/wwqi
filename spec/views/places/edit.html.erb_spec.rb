require 'spec_helper'

describe "places/edit.html.erb" do
  before(:each) do
    assign(:place, @place = stub_model(Place,
      :new_record? => false,
      :name => "MyString",
      :latitude => "MyString",
      :longitude => "MyString",
      :x => 1,
      :y => 1,
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders the edit place form" do
    render

    response.should have_selector("form", :action => place_path(@place), :method => "post") do |form|
      form.should have_selector("input#place_name", :name => "place[name]")
      form.should have_selector("input#place_latitude", :name => "place[latitude]")
      form.should have_selector("input#place_longitude", :name => "place[longitude]")
      form.should have_selector("input#place_x", :name => "place[x]")
      form.should have_selector("input#place_y", :name => "place[y]")
      form.should have_selector("input#place_publish", :name => "place[publish]")
      form.should have_selector("textarea#place_notes", :name => "place[notes]")
    end
  end
end
