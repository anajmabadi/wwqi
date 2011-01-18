require 'spec_helper'

describe "Months" do
  describe "GET /months" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get months_path
      response.status.should be(200)
    end
  end
end
