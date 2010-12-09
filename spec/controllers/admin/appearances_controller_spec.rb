require 'spec_helper'

describe Admin::AppearancesController do

  def mock_appearance(stubs={})
    @mock_appearance ||= mock_model(Appearance, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all appearances as @appearances" do
      Appearance.stub(:all) { [mock_appearance] }
      get :index
      assigns(:appearances).should eq([mock_appearance])
    end
  end

  describe "GET show" do
    it "assigns the requested appearance as @appearance" do
      Appearance.stub(:find).with("37") { mock_appearance }
      get :show, :id => "37"
      assigns(:appearance).should be(mock_appearance)
    end
  end

  describe "GET new" do
    it "assigns a new appearance as @appearance" do
      Appearance.stub(:new) { mock_appearance }
      get :new
      assigns(:appearance).should be(mock_appearance)
    end
  end

  describe "GET edit" do
    it "assigns the requested appearance as @appearance" do
      Appearance.stub(:find).with("37") { mock_appearance }
      get :edit, :id => "37"
      assigns(:appearance).should be(mock_appearance)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created appearance as @appearance" do
        Appearance.stub(:new).with({'these' => 'params'}) { mock_appearance(:save => true) }
        post :create, :appearance => {'these' => 'params'}
        assigns(:appearance).should be(mock_appearance)
      end

      it "redirects to the created appearance" do
        Appearance.stub(:new) { mock_appearance(:save => true) }
        post :create, :appearance => {}
        response.should redirect_to(admin_appearance_url(mock_appearance))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved appearance as @appearance" do
        Appearance.stub(:new).with({'these' => 'params'}) { mock_appearance(:save => false) }
        post :create, :appearance => {'these' => 'params'}
        assigns(:appearance).should be(mock_appearance)
      end

      it "re-renders the 'new' template" do
        Appearance.stub(:new) { mock_appearance(:save => false) }
        post :create, :appearance => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested appearance" do
        Appearance.should_receive(:find).with("37") { mock_appearance }
        mock_appearance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :appearance => {'these' => 'params'}
      end

      it "assigns the requested appearance as @appearance" do
        Appearance.stub(:find) { mock_appearance(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:appearance).should be(mock_appearance)
      end

      it "redirects to the appearance" do
        Appearance.stub(:find) { mock_appearance(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_appearance_url(mock_appearance))
      end
    end

    describe "with invalid params" do
      it "assigns the appearance as @appearance" do
        Appearance.stub(:find) { mock_appearance(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:appearance).should be(mock_appearance)
      end

      it "re-renders the 'edit' template" do
        Appearance.stub(:find) { mock_appearance(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested appearance" do
      Appearance.should_receive(:find).with("37") { mock_appearance }
      mock_appearance.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the appearances list" do
      Appearance.stub(:find) { mock_appearance(:destroy => true) }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_appearances_url)
    end
  end

end
