require 'spec_helper'

describe "subject_types/index.html.erb" do
  before(:each) do
    assign(:subject_types, [
      stub_model(SubjectType,
        :name => "MyString",
        :description => "MyText",
        :publish => false,
        :notes => "MyText"
      ),
      stub_model(SubjectType,
        :name => "MyString",
        :description => "MyText",
        :publish => false,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of subject_types" do
    render
    rendered.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => false.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
