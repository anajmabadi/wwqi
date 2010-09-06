require 'spec_helper'

describe "passports/index.html.erb" do
  before(:each) do
    assign(:passports, [
      stub_model(Passport,
        :tag => "Tag",
        :owner_id => 1,
        :item_id => 1,
        :publish => false,
        :primary => false,
        :position => 1,
        :notes => "MyText",
        :custom_url => "Custom Url"
      ),
      stub_model(Passport,
        :tag => "Tag",
        :owner_id => 1,
        :item_id => 1,
        :publish => false,
        :primary => false,
        :position => 1,
        :notes => "MyText",
        :custom_url => "Custom Url"
      )
    ])
  end

  it "renders a list of passports" do
    render
    rendered.should have_selector("tr>td", :content => "Tag".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => false.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => false.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Custom Url".to_s, :count => 2)
  end
end
