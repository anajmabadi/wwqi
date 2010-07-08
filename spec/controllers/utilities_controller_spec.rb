require 'spec_helper'

describe UtilitiesController do

  def mock_utility(stubs={})
    @mock_utility ||= mock_model(Utility, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all utilities as @utilities" do
      Utility.stub(:all) { [mock_utility] }
      get :index
      assigns(:utilities).should eq([mock_utility])
    end
  end

  describe "GET show" do
    it "assigns the requested utility as @utility" do
      Utility.stub(:find).with("37") { mock_utility }
      get :show, :id => "37"
      assigns(:utility).should be(mock_utility)
    end
  end

  describe "GET new" do
    it "assigns a new utility as @utility" do
      Utility.stub(:new) { mock_utility }
      get :new
      assigns(:utility).should be(mock_utility)
    end
  end

  describe "GET edit" do
    it "assigns the requested utility as @utility" do
      Utility.stub(:find).with("37") { mock_utility }
      get :edit, :id => "37"
      assigns(:utility).should be(mock_utility)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created utility as @utility" do
        Utility.stub(:new).with({'these' => 'params'}) { mock_utility(:save => true) }
        post :create, :utility => {'these' => 'params'}
        assigns(:utility).should be(mock_utility)
      end

      it "redirects to the created utility" do
        Utility.stub(:new) { mock_utility(:save => true) }
        post :create, :utility => {}
        response.should redirect_to(utility_url(mock_utility))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved utility as @utility" do
        Utility.stub(:new).with({'these' => 'params'}) { mock_utility(:save => false) }
        post :create, :utility => {'these' => 'params'}
        assigns(:utility).should be(mock_utility)
      end

      it "re-renders the 'new' template" do
        Utility.stub(:new) { mock_utility(:save => false) }
        post :create, :utility => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested utility" do
        Utility.should_receive(:find).with("37") { mock_utility }
        mock_utility.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :utility => {'these' => 'params'}
      end

      it "assigns the requested utility as @utility" do
        Utility.stub(:find) { mock_utility(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:utility).should be(mock_utility)
      end

      it "redirects to the utility" do
        Utility.stub(:find) { mock_utility(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(utility_url(mock_utility))
      end
    end

    describe "with invalid params" do
      it "assigns the utility as @utility" do
        Utility.stub(:find) { mock_utility(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:utility).should be(mock_utility)
      end

      it "re-renders the 'edit' template" do
        Utility.stub(:find) { mock_utility(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested utility" do
      Utility.should_receive(:find).with("37") { mock_utility }
      mock_utility.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the utilities list" do
      Utility.stub(:find) { mock_utility }
      delete :destroy, :id => "1"
      response.should redirect_to(utilities_url)
    end
  end

end
