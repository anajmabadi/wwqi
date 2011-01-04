require 'spec_helper'

describe "alternate_titles/show.html.erb" do
  before(:each) do
    @alternate_title = assign(:alternate_title, stub_model(AlternateTitle,
      :name => "Name",
      :caption => "MyText",
      :publish => false,
      :notes => "Notes"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Notes/)
  end
end
