require 'spec_helper'
require 'home_helper'

describe "home/index.html.erb" do
  
  before(:each) do
    assigns[:about_page] = stub("Page", :title => 'About', :body => '<p>Hello World!</p>')
    assigns[:featured_exhibit] = stub("Exhibition", :title => 'Sample Exhibit', :description => "Sample Description", :featured => true)
  end   
  
  it "displays the correct title and about message" do
    render
    response.should contain("About")
    response.should containt("Hello World")
  end  
  
end
