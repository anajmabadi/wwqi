require 'spec_helper'

describe "eras/new.html.erb" do
  before(:each) do
    assign(:era, stub_model(Era,
      :title => "MyString",
      :year => 1,
      :publish => false
    ).as_new_record)
  end

  it "renders new era form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => eras_path, :method => "post" do
      assert_select "input#era_title", :name => "era[title]"
      assert_select "input#era_year", :name => "era[year]"
      assert_select "input#era_publish", :name => "era[publish]"
    end
  end
end
