require 'spec_helper'

describe "repositories/show.html.erb" do
  before(:each) do
    @repository = assign(:repository, stub_model(Repository,
      :name => "Name",
      :owner_id => 1,
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Name".to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(false.to_s)
    rendered.should contain("MyText".to_s)
  end
end
