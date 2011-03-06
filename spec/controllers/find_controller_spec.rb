require 'spec_helper'

describe FindController do

  describe "GET 'item'" do
    it "should be successful" do
      get 'item'
      response.should be_success
    end
  end

  describe "GET 'collection'" do
    it "should be successful" do
      get 'collection'
      response.should be_success
    end
  end

end
