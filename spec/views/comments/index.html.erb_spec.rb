require 'spec_helper'

describe "comments/index.html.erb" do
  before(:each) do
    assign(:comments, [
      stub_model(Comment,
        :subject => "Subject",
        :body => "MyText",
        :ip => "Ip",
        :name => "Name",
        :email => "Email",
        :notes => "MyText"
      ),
      stub_model(Comment,
        :subject => "Subject",
        :body => "MyText",
        :ip => "Ip",
        :name => "Name",
        :email => "Email",
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of comments" do
    render
    rendered.should have_selector("tr>td", :content => "Subject".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Ip".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Name".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Email".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
