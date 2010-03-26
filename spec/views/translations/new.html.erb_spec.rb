require 'spec_helper'

describe "translations/new.html.erb" do
  before(:each) do
    assign(:translation, stub_model(Translation,
      :new_record? => true,
      :locale => "MyString",
      :key => "MyString",
      :value => "MyText",
      :interpolations => "MyText",
      :is_proc => false
    ))
  end

  it "renders new translation form" do
    render

    response.should have_selector("form", :action => translations_path, :method => "post") do |form|
      form.should have_selector("input#translation_locale", :name => "translation[locale]")
      form.should have_selector("input#translation_key", :name => "translation[key]")
      form.should have_selector("textarea#translation_value", :name => "translation[value]")
      form.should have_selector("textarea#translation_interpolations", :name => "translation[interpolations]")
      form.should have_selector("input#translation_is_proc", :name => "translation[is_proc]")
    end
  end
end
