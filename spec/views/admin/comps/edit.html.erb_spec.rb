require 'spec_helper'

describe "admin/comps/edit.html.erb" do
  before(:each) do
    @comp = assign(:comp, stub_model(Comp,
      :item_id => 1,
      :comp_id => 2,
      :position => 1,
      :publish => false,
      :notes => "MyString"
    ))
  end

  it "renders the edit comp form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_comp_path(@comp), :method => "post" do
      assert_select "input#comp_item_id", :name => "comp[item_id]"
      assert_select "input#comp_comp_id", :name => "comp[comp_id]"
      assert_select "input#comp_position", :name => "comp[position]"
      assert_select "input#comp_publish", :name => "comp[publish]"
      assert_select "input#comp_notes", :name => "comp[notes]"
    end
  end
end
