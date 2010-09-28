require 'spec_helper'

describe "admin_appellations/show.html.erb" do
  before(:each) do
    @appellation = assign(:appellation, stub_model(Admin::Appellation))
  end

  it "renders attributes in <p>" do
    render
  end
end
