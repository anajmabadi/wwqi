require 'spec_helper'

describe "comments/edit.html.erb" do
  before(:each) do
    @comment = assign(:comment, stub_model(Comment,
      :new_record? => false,
      :subject => "MyString",
      :body => "MyText",
      :ip => "MyString",
      :name => "MyString",
      :email => "MyString",
      :notes => "MyText"
    ))
  end

  it "renders the edit comment form" do
    render

    rendered.should have_selector("form", :action => comment_path(@comment), :method => "post") do |form|
      form.should have_selector("input#comment_subject", :name => "comment[subject]")
      form.should have_selector("textarea#comment_body", :name => "comment[body]")
      form.should have_selector("input#comment_ip", :name => "comment[ip]")
      form.should have_selector("input#comment_name", :name => "comment[name]")
      form.should have_selector("input#comment_email", :name => "comment[email]")
      form.should have_selector("textarea#comment_notes", :name => "comment[notes]")
    end
  end
end
