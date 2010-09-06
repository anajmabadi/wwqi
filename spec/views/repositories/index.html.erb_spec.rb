require 'spec_helper'

describe "repositories/index.html.erb" do
  before(:each) do
    assign(:repositories, [
      stub_model(Repository,
        :name => "Name",
        :owner_id => 1,
        :publish => false,
        :notes => "MyText"
      ),
      stub_model(Repository,
        :name => "Name",
        :owner_id => 1,
        :publish => false,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of repositories" do
    render
    rendered.should have_selector("tr>td", :content => "Name".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => false.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
