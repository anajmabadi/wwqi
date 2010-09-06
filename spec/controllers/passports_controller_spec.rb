require 'spec_helper'

describe PassportsController do

  def mock_passport(stubs={})
    @mock_passport ||= mock_model(Passport, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all passports as @passports" do
      Passport.stub(:all) { [mock_passport] }
      get :index
      assigns(:passports).should eq([mock_passport])
    end
  end

  describe "GET show" do
    it "assigns the requested passport as @passport" do
      Passport.stub(:find).with("37") { mock_passport }
      get :show, :id => "37"
      assigns(:passport).should be(mock_passport)
    end
  end

  describe "GET new" do
    it "assigns a new passport as @passport" do
      Passport.stub(:new) { mock_passport }
      get :new
      assigns(:passport).should be(mock_passport)
    end
  end

  describe "GET edit" do
    it "assigns the requested passport as @passport" do
      Passport.stub(:find).with("37") { mock_passport }
      get :edit, :id => "37"
      assigns(:passport).should be(mock_passport)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created passport as @passport" do
        Passport.stub(:new).with({'these' => 'params'}) { mock_passport(:save => true) }
        post :create, :passport => {'these' => 'params'}
        assigns(:passport).should be(mock_passport)
      end

      it "redirects to the created passport" do
        Passport.stub(:new) { mock_passport(:save => true) }
        post :create, :passport => {}
        response.should redirect_to(passport_url(mock_passport))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved passport as @passport" do
        Passport.stub(:new).with({'these' => 'params'}) { mock_passport(:save => false) }
        post :create, :passport => {'these' => 'params'}
        assigns(:passport).should be(mock_passport)
      end

      it "re-renders the 'new' template" do
        Passport.stub(:new) { mock_passport(:save => false) }
        post :create, :passport => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested passport" do
        Passport.should_receive(:find).with("37") { mock_passport }
        mock_passport.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :passport => {'these' => 'params'}
      end

      it "assigns the requested passport as @passport" do
        Passport.stub(:find) { mock_passport(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:passport).should be(mock_passport)
      end

      it "redirects to the passport" do
        Passport.stub(:find) { mock_passport(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(passport_url(mock_passport))
      end
    end

    describe "with invalid params" do
      it "assigns the passport as @passport" do
        Passport.stub(:find) { mock_passport(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:passport).should be(mock_passport)
      end

      it "re-renders the 'edit' template" do
        Passport.stub(:find) { mock_passport(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested passport" do
      Passport.should_receive(:find).with("37") { mock_passport }
      mock_passport.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the passports list" do
      Passport.stub(:find) { mock_passport }
      delete :destroy, :id => "1"
      response.should redirect_to(passports_url)
    end
  end

end
