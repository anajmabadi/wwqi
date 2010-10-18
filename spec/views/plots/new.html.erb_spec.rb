require 'spec_helper'

describe "plots/new.html.erb" do
  before(:each) do
    assign(:plot, stub_model(Plot,
      :new_record? => true,
      :item_id => 1,
      :place_id => 1,
      :notes => "MyText",
      :publish => false,
      :position => 1
    ))
  end

  it "renders new plot form" do
    render

    rendered.should have_selector("form", :action => plots_path, :method => "post") do |form|
      form.should have_selector("input#plot_item_id", :name => "plot[item_id]")
      form.should have_selector("input#plot_place_id", :name => "plot[place_id]")
      form.should have_selector("textarea#plot_notes", :name => "plot[notes]")
      form.should have_selector("input#plot_publish", :name => "plot[publish]")
      form.should have_selector("input#plot_position", :name => "plot[position]")
    end
  end
end
