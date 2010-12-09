require 'spec_helper'

describe "passports/show.html.erb" do
  before(:each) do
    @passport = assign(:passport, stub_model(Passport,
      :tag => "Tag",
      :owner_id => 1,
      :item_id => 1,
      :publish => false,
      :primary => false,
      :position => 1,
      :notes => "MyText",
      :custom_url => "Custom Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Tag".to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(false.to_s)
    rendered.should contain(false.to_s)
    rendered.should contain(1.to_s)
    rendered.should contain("MyText".to_s)
    rendered.should contain("Custom Url".to_s)
  end
end
