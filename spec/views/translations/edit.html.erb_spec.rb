require 'spec_helper'

describe "translations/edit.html.erb" do
  before(:each) do
    assign(:translation, @translation = stub_model(Translation,
      :new_record? => false,
      :locale => "MyString",
      :key => "MyString",
      :value => "MyText",
      :interpolations => "MyText",
      :is_proc => false
    ))
  end

  it "renders the edit translation form" do
    render

    response.should have_selector("form", :action => translation_path(@translation), :method => "post") do |form|
      form.should have_selector("input#translation_locale", :name => "translation[locale]")
      form.should have_selector("input#translation_key", :name => "translation[key]")
      form.should have_selector("textarea#translation_value", :name => "translation[value]")
      form.should have_selector("textarea#translation_interpolations", :name => "translation[interpolations]")
      form.should have_selector("input#translation_is_proc", :name => "translation[is_proc]")
    end
  end
end
