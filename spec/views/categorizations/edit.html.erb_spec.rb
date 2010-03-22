require 'spec_helper'

describe "categorizations/edit.html.erb" do
  before(:each) do
    assign(:categorization, @categorization = stub_model(Categorization,
      :new_record? => false,
      :category_id => 1,
      :item_id => 1
    ))
  end

  it "renders the edit categorization form" do
    render

    response.should have_selector("form", :action => categorization_path(@categorization), :method => "post") do |form|
      form.should have_selector("input#categorization_category_id", :name => "categorization[category_id]")
      form.should have_selector("input#categorization_item_id", :name => "categorization[item_id]")
    end
  end
end
