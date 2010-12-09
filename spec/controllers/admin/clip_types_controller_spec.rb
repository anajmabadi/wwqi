require 'spec_helper'

describe Admin::ClipTypesController do

  def mock_clip_type(stubs={})
    @mock_clip_type ||= mock_model(ClipType, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all clip_types as @clip_types" do
      ClipType.stub(:all) { [mock_clip_type] }
      get :index
      assigns(:clip_types).should eq([mock_clip_type])
    end
  end

  describe "GET show" do
    it "assigns the requested clip_type as @clip_type" do
      ClipType.stub(:find).with("37") { mock_clip_type }
      get :show, :id => "37"
      assigns(:clip_type).should be(mock_clip_type)
    end
  end

  describe "GET new" do
    it "assigns a new clip_type as @clip_type" do
      ClipType.stub(:new) { mock_clip_type }
      get :new
      assigns(:clip_type).should be(mock_clip_type)
    end
  end

  describe "GET edit" do
    it "assigns the requested clip_type as @clip_type" do
      ClipType.stub(:find).with("37") { mock_clip_type }
      get :edit, :id => "37"
      assigns(:clip_type).should be(mock_clip_type)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created clip_type as @clip_type" do
        ClipType.stub(:new).with({'these' => 'params'}) { mock_clip_type(:save => true) }
        post :create, :clip_type => {'these' => 'params'}
        assigns(:clip_type).should be(mock_clip_type)
      end

      it "redirects to the created clip_type" do
        ClipType.stub(:new) { mock_clip_type(:save => true) }
        post :create, :clip_type => {}
        response.should redirect_to(admin_clip_type_url(mock_clip_type))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved clip_type as @clip_type" do
        ClipType.stub(:new).with({'these' => 'params'}) { mock_clip_type(:save => false) }
        post :create, :clip_type => {'these' => 'params'}
        assigns(:clip_type).should be(mock_clip_type)
      end

      it "re-renders the 'new' template" do
        ClipType.stub(:new) { mock_clip_type(:save => false) }
        post :create, :clip_type => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested clip_type" do
        ClipType.should_receive(:find).with("37") { mock_clip_type }
        mock_clip_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :clip_type => {'these' => 'params'}
      end

      it "assigns the requested clip_type as @clip_type" do
        ClipType.stub(:find) { mock_clip_type(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:clip_type).should be(mock_clip_type)
      end

      it "redirects to the clip_type" do
        ClipType.stub(:find) { mock_clip_type(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_clip_type_url(mock_clip_type))
      end
    end

    describe "with invalid params" do
      it "assigns the clip_type as @clip_type" do
        ClipType.stub(:find) { mock_clip_type(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:clip_type).should be(mock_clip_type)
      end

      it "re-renders the 'edit' template" do
        ClipType.stub(:find) { mock_clip_type(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested clip_type" do
      ClipType.should_receive(:find).with("37") { mock_clip_type }
      mock_clip_type.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the clip_types list" do
      ClipType.stub(:find) { mock_clip_type(:destroy => true) }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_clip_types_url)
    end
  end

end
