require 'spec_helper'

describe "admin_appellations/edit.html.erb" do
  before(:each) do
    @appellation = assign(:appellation, stub_model(Admin::Appellation,
      :new_record? => false
    ))
  end

  it "renders the edit appellation form" do
    render

    rendered.should have_selector("form", :action => appellation_path(@appellation), :method => "post") do |form|
    end
  end
end
