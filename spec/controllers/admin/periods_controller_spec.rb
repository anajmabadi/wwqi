require 'spec_helper'

describe Admin::PeriodsController do

  def mock_period(stubs={})
    @mock_period ||= mock_model(Period, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all periods as @periods" do
      Period.stub(:all) { [mock_period] }
      get :index
      assigns(:periods).should eq([mock_period])
    end
  end

  describe "GET show" do
    it "assigns the requested period as @period" do
      Period.stub(:find).with("37") { mock_period }
      get :show, :id => "37"
      assigns(:period).should be(mock_period)
    end
  end

  describe "GET new" do
    it "assigns a new period as @period" do
      Period.stub(:new) { mock_period }
      get :new
      assigns(:period).should be(mock_period)
    end
  end

  describe "GET edit" do
    it "assigns the requested period as @period" do
      Period.stub(:find).with("37") { mock_period }
      get :edit, :id => "37"
      assigns(:period).should be(mock_period)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created period as @period" do
        Period.stub(:new).with({'these' => 'params'}) { mock_period(:save => true) }
        post :create, :period => {'these' => 'params'}
        assigns(:period).should be(mock_period)
      end

      it "redirects to the created period" do
        Period.stub(:new) { mock_period(:save => true) }
        post :create, :period => {}
        response.should redirect_to(admin_period_url(mock_period))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved period as @period" do
        Period.stub(:new).with({'these' => 'params'}) { mock_period(:save => false) }
        post :create, :period => {'these' => 'params'}
        assigns(:period).should be(mock_period)
      end

      it "re-renders the 'new' template" do
        Period.stub(:new) { mock_period(:save => false) }
        post :create, :period => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested period" do
        Period.should_receive(:find).with("37") { mock_period }
        mock_period.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :period => {'these' => 'params'}
      end

      it "assigns the requested period as @period" do
        Period.stub(:find) { mock_period(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:period).should be(mock_period)
      end

      it "redirects to the period" do
        Period.stub(:find) { mock_period(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_period_url(mock_period))
      end
    end

    describe "with invalid params" do
      it "assigns the period as @period" do
        Period.stub(:find) { mock_period(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:period).should be(mock_period)
      end

      it "re-renders the 'edit' template" do
        Period.stub(:find) { mock_period(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested period" do
      Period.should_receive(:find).with("37") { mock_period }
      mock_period.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the periods list" do
      Period.stub(:find) { mock_period(:destroy => true) }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_periods_url)
    end
  end

end
