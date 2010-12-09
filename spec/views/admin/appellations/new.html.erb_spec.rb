require 'spec_helper'

describe "admin_appellations/new.html.erb" do
  before(:each) do
    assign(:appellation, stub_model(Appellation,
      :new_record? => true
    ))
  end

  it "renders new appellation form" do
    render

    rendered.should have_selector("form", :action => admin_appellations_path, :method => "post") do |form|
    end
  end
end
