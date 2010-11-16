require 'spec_helper'

describe "comments/show.html.erb" do
  before(:each) do
    @comment = assign(:comment, stub_model(Comment,
      :subject => "Subject",
      :body => "MyText",
      :ip => "Ip",
      :name => "Name",
      :email => "Email",
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Subject".to_s)
    rendered.should contain("MyText".to_s)
    rendered.should contain("Ip".to_s)
    rendered.should contain("Name".to_s)
    rendered.should contain("Email".to_s)
    rendered.should contain("MyText".to_s)
  end
end
