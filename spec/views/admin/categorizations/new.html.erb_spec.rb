require 'spec_helper'

describe "categorizations/new.html.erb" do
  before(:each) do
    assign(:categorization, stub_model(Categorization,
      :new_record? => true,
      :category_id => 1,
      :item_id => 1
    ))
  end

  it "renders new categorization form" do
    render

    response.should have_selector("form", :action => categorizations_path, :method => "post") do |form|
      form.should have_selector("input#categorization_category_id", :name => "categorization[category_id]")
      form.should have_selector("input#categorization_item_id", :name => "categorization[item_id]")
    end
  end
end
