require 'spec_helper'

describe "subject_types/show.html.erb" do
  before(:each) do
    assign(:subject_type, @subject_type = stub_model(SubjectType,
      :name => "MyString",
      :description => "MyText",
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
   rendered.should contain("MyString")
   rendered.should contain("MyText")
   rendered.should contain(false)
   rendered.should contain("MyText")
  end
end
