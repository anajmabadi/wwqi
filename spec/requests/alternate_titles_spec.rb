require 'spec_helper'

describe "AlternateTitles" do
  describe "GET /alternate_titles" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get alternate_titles_path
      response.status.should be(200)
    end
  end
end
