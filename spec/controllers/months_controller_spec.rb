require 'spec_helper'

describe MonthsController do

  def mock_month(stubs={})
    (@mock_month ||= mock_model(Month).as_null_object).tap do |month|
      month.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all months as @months" do
      Month.stub(:all) { [mock_month] }
      get :index
      assigns(:months).should eq([mock_month])
    end
  end

  describe "GET show" do
    it "assigns the requested month as @month" do
      Month.stub(:find).with("37") { mock_month }
      get :show, :id => "37"
      assigns(:month).should be(mock_month)
    end
  end

  describe "GET new" do
    it "assigns a new month as @month" do
      Month.stub(:new) { mock_month }
      get :new
      assigns(:month).should be(mock_month)
    end
  end

  describe "GET edit" do
    it "assigns the requested month as @month" do
      Month.stub(:find).with("37") { mock_month }
      get :edit, :id => "37"
      assigns(:month).should be(mock_month)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created month as @month" do
        Month.stub(:new).with({'these' => 'params'}) { mock_month(:save => true) }
        post :create, :month => {'these' => 'params'}
        assigns(:month).should be(mock_month)
      end

      it "redirects to the created month" do
        Month.stub(:new) { mock_month(:save => true) }
        post :create, :month => {}
        response.should redirect_to(month_url(mock_month))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved month as @month" do
        Month.stub(:new).with({'these' => 'params'}) { mock_month(:save => false) }
        post :create, :month => {'these' => 'params'}
        assigns(:month).should be(mock_month)
      end

      it "re-renders the 'new' template" do
        Month.stub(:new) { mock_month(:save => false) }
        post :create, :month => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested month" do
        Month.should_receive(:find).with("37") { mock_month }
        mock_month.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :month => {'these' => 'params'}
      end

      it "assigns the requested month as @month" do
        Month.stub(:find) { mock_month(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:month).should be(mock_month)
      end

      it "redirects to the month" do
        Month.stub(:find) { mock_month(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(month_url(mock_month))
      end
    end

    describe "with invalid params" do
      it "assigns the month as @month" do
        Month.stub(:find) { mock_month(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:month).should be(mock_month)
      end

      it "re-renders the 'edit' template" do
        Month.stub(:find) { mock_month(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested month" do
      Month.should_receive(:find).with("37") { mock_month }
      mock_month.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the months list" do
      Month.stub(:find) { mock_month }
      delete :destroy, :id => "1"
      response.should redirect_to(months_url)
    end
  end

end
