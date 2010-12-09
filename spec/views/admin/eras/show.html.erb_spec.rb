require 'spec_helper'

describe "eras/show.html.erb" do
  before(:each) do
    @era = assign(:era, stub_model(Era,
      :title => "Title",
      :year => 1,
      :publish => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
