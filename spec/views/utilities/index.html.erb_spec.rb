require 'spec_helper'

describe "utilities/index.html.erb" do
  before(:each) do
    assign(:utilities, [
      stub_model(Utility),
      stub_model(Utility)
    ])
  end

  it "renders a list of utilities" do
    render
  end
end
