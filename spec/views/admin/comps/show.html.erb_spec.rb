require 'spec_helper'

describe "admin/comps/show.html.erb" do
  before(:each) do
    @comp = assign(:comp, stub_model(Comp,
      :item_id => 1,
      :comp_id => 2,
      :position => 3,
      :publish => false,
      :notes => "Notes"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/2/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/3/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Notes/)
  end
end
