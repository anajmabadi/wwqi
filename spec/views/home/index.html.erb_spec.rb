require 'spec_helper'
require 'home_helper'

describe "home/index.html.erb" do
  
  before(:each) do
    assign(:about_page, stub_model(Page,
        :title => "About",
        :caption => "<p>Hello world.</p>",
        :publish => true
      ))
  end   
  
  it "displays the correct title and about message" do
    render
    response.should contain("Hello world")
  end  
  
end
