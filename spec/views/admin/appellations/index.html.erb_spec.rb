require 'spec_helper'

describe "admin_appellations/index.html.erb" do
  before(:each) do
    assign(:admin_appellations, [
      stub_model(Admin::Appellation),
      stub_model(Admin::Appellation)
    ])
  end

  it "renders a list of admin_appellations" do
    render
  end
end
