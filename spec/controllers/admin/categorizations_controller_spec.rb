require 'spec_helper'

describe Admin::CategorizationsController do

  def mock_categorization(stubs={})
    @mock_categorization ||= mock_model(Categorization, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all categorizations as @categorizations" do
      Categorization.stub(:all) { [mock_categorization] }
      get :index
      assigns(:categorizations).should eq([mock_categorization])
    end
  end

  describe "GET show" do
    it "assigns the requested categorization as @categorization" do
      Categorization.stub(:find).with("37") { mock_categorization }
      get :show, :id => "37"
      assigns(:categorization).should be(mock_categorization)
    end
  end

  describe "GET new" do
    it "assigns a new categorization as @categorization" do
      Categorization.stub(:new) { mock_categorization }
      get :new
      assigns(:categorization).should be(mock_categorization)
    end
  end

  describe "GET edit" do
    it "assigns the requested categorization as @categorization" do
      Categorization.stub(:find).with("37") { mock_categorization }
      get :edit, :id => "37"
      assigns(:categorization).should be(mock_categorization)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created categorization as @categorization" do
        Categorization.stub(:new).with({'these' => 'params'}) { mock_categorization(:save => true) }
        post :create, :categorization => {'these' => 'params'}
        assigns(:categorization).should be(mock_categorization)
      end

      it "redirects to the created categorization" do
        Categorization.stub(:new) { mock_categorization(:save => true) }
        post :create, :categorization => {}
        response.should redirect_to(admin_categorization_url(mock_categorization))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved categorization as @categorization" do
        Categorization.stub(:new).with({'these' => 'params'}) { mock_categorization(:save => false) }
        post :create, :categorization => {'these' => 'params'}
        assigns(:categorization).should be(mock_categorization)
      end

      it "re-renders the 'new' template" do
        Categorization.stub(:new) { mock_categorization(:save => false) }
        post :create, :categorization => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested categorization" do
        Categorization.should_receive(:find).with("37") { mock_categorization }
        mock_categorization.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :categorization => {'these' => 'params'}
      end

      it "assigns the requested categorization as @categorization" do
        Categorization.stub(:find) { mock_categorization(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:categorization).should be(mock_categorization)
      end

      it "redirects to the categorization" do
        Categorization.stub(:find) { mock_categorization(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_categorization_url(mock_categorization))
      end
    end

    describe "with invalid params" do
      it "assigns the categorization as @categorization" do
        Categorization.stub(:find) { mock_categorization(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:categorization).should be(mock_categorization)
      end

      it "re-renders the 'edit' template" do
        Categorization.stub(:find) { mock_categorization(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested categorization" do
      Categorization.should_receive(:find).with("37") { mock_categorization }
      mock_categorization.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the categorizations list" do
      Categorization.stub(:find) { mock_categorization(:destroy => true) }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_categorizations_url)
    end
  end

end
