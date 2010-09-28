require 'spec_helper'

describe Admin::AppellationsController do

  def mock_appellation(stubs={})
    @mock_appellation ||= mock_model(Admin::Appellation, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all admin_appellations as @admin_appellations" do
      Admin::Appellation.stub(:all) { [mock_appellation] }
      get :index
      assigns(:admin_appellations).should eq([mock_appellation])
    end
  end

  describe "GET show" do
    it "assigns the requested appellation as @appellation" do
      Admin::Appellation.stub(:find).with("37") { mock_appellation }
      get :show, :id => "37"
      assigns(:appellation).should be(mock_appellation)
    end
  end

  describe "GET new" do
    it "assigns a new appellation as @appellation" do
      Admin::Appellation.stub(:new) { mock_appellation }
      get :new
      assigns(:appellation).should be(mock_appellation)
    end
  end

  describe "GET edit" do
    it "assigns the requested appellation as @appellation" do
      Admin::Appellation.stub(:find).with("37") { mock_appellation }
      get :edit, :id => "37"
      assigns(:appellation).should be(mock_appellation)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created appellation as @appellation" do
        Admin::Appellation.stub(:new).with({'these' => 'params'}) { mock_appellation(:save => true) }
        post :create, :appellation => {'these' => 'params'}
        assigns(:appellation).should be(mock_appellation)
      end

      it "redirects to the created appellation" do
        Admin::Appellation.stub(:new) { mock_appellation(:save => true) }
        post :create, :appellation => {}
        response.should redirect_to(admin_appellation_url(mock_appellation))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved appellation as @appellation" do
        Admin::Appellation.stub(:new).with({'these' => 'params'}) { mock_appellation(:save => false) }
        post :create, :appellation => {'these' => 'params'}
        assigns(:appellation).should be(mock_appellation)
      end

      it "re-renders the 'new' template" do
        Admin::Appellation.stub(:new) { mock_appellation(:save => false) }
        post :create, :appellation => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested appellation" do
        Admin::Appellation.should_receive(:find).with("37") { mock_appellation }
        mock_admin_appellation.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :appellation => {'these' => 'params'}
      end

      it "assigns the requested appellation as @appellation" do
        Admin::Appellation.stub(:find) { mock_appellation(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:appellation).should be(mock_appellation)
      end

      it "redirects to the appellation" do
        Admin::Appellation.stub(:find) { mock_appellation(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_appellation_url(mock_appellation))
      end
    end

    describe "with invalid params" do
      it "assigns the appellation as @appellation" do
        Admin::Appellation.stub(:find) { mock_appellation(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:appellation).should be(mock_appellation)
      end

      it "re-renders the 'edit' template" do
        Admin::Appellation.stub(:find) { mock_appellation(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested appellation" do
      Admin::Appellation.should_receive(:find).with("37") { mock_appellation }
      mock_admin_appellation.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the admin_appellations list" do
      Admin::Appellation.stub(:find) { mock_appellation }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_appellations_url)
    end
  end

end
