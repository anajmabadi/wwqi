require 'spec_helper'

describe Admin::PanelsController do

  def mock_panel(stubs={})
    @mock_panel ||= mock_model(Panel, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all panels as @panels" do
      Panel.stub(:all) { [mock_panel] }
      get :index
      assigns(:panels).should eq([mock_panel])
    end
  end

  describe "GET show" do
    it "assigns the requested panel as @panel" do
      Panel.stub(:find).with("37") { mock_panel }
      get :show, :id => "37"
      assigns(:panel).should be(mock_panel)
    end
  end

  describe "GET new" do
    it "assigns a new panel as @panel" do
      Panel.stub(:new) { mock_panel }
      get :new
      assigns(:panel).should be(mock_panel)
    end
  end

  describe "GET edit" do
    it "assigns the requested panel as @panel" do
      Panel.stub(:find).with("37") { mock_panel }
      get :edit, :id => "37"
      assigns(:panel).should be(mock_panel)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created panel as @panel" do
        Panel.stub(:new).with({'these' => 'params'}) { mock_panel(:save => true) }
        post :create, :panel => {'these' => 'params'}
        assigns(:panel).should be(mock_panel)
      end

      it "redirects to the created panel" do
        Panel.stub(:new) { mock_panel(:save => true) }
        post :create, :panel => {}
        response.should redirect_to(admin_panel_url(mock_panel))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved panel as @panel" do
        Panel.stub(:new).with({'these' => 'params'}) { mock_panel(:save => false) }
        post :create, :panel => {'these' => 'params'}
        assigns(:panel).should be(mock_panel)
      end

      it "re-renders the 'new' template" do
        Panel.stub(:new) { mock_panel(:save => false) }
        post :create, :panel => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested panel" do
        Panel.should_receive(:find).with("37") { mock_panel }
        mock_panel.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :panel => {'these' => 'params'}
      end

      it "assigns the requested panel as @panel" do
        Panel.stub(:find) { mock_panel(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:panel).should be(mock_panel)
      end

      it "redirects to the panel" do
        Panel.stub(:find) { mock_panel(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_panel_url(mock_panel))
      end
    end

    describe "with invalid params" do
      it "assigns the panel as @panel" do
        Panel.stub(:find) { mock_panel(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:panel).should be(mock_panel)
      end

      it "re-renders the 'edit' template" do
        Panel.stub(:find) { mock_panel(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested panel" do
      Panel.should_receive(:find).with("37") { mock_panel }
      mock_panel.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the panels list" do
      Panel.stub(:find) { mock_panel(:destroy => true) }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_panels_url)
    end
  end

end
