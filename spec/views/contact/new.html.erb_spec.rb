require 'spec_helper'

describe "contact/new.html.erb" do
  before(:each) do
    assign(:page, stub_model(Page,
        :title => "Contact Us",
        :caption => "<p>Fill out the form.</p>",
        :publish => true
      ))
    assign(:comment, stub_model(Comment,
      :new_record? => true))
    assign(:ip, "127.0.0.1")
  end   
  
  it "displays the correct caption message" do
    render
    response.should contain("Fill out the form.")
  end  
end
