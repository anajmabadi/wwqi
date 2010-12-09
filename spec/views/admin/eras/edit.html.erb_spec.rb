require 'spec_helper'

describe "eras/edit.html.erb" do
  before(:each) do
    @era = assign(:era, stub_model(Era,
      :new_record? => false,
      :title => "MyString",
      :year => 1,
      :publish => false
    ))
  end

  it "renders the edit era form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => era_path(@era), :method => "post" do
      assert_select "input#era_title", :name => "era[title]"
      assert_select "input#era_year", :name => "era[year]"
      assert_select "input#era_publish", :name => "era[publish]"
    end
  end
end
