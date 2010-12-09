require 'spec_helper'

describe Admin::ClipsController do

  def mock_clip(stubs={})
    @mock_clip ||= mock_model(Clip, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all clips as @clips" do
      Clip.stub(:all) { [mock_clip] }
      get :index
      assigns(:clips).should eq([mock_clip])
    end
  end

  describe "GET show" do
    it "assigns the requested clip as @clip" do
      Clip.stub(:find).with("37") { mock_clip }
      get :show, :id => "37"
      assigns(:clip).should be(mock_clip)
    end
  end

  describe "GET new" do
    it "assigns a new clip as @clip" do
      Clip.stub(:new) { mock_clip }
      get :new
      assigns(:clip).should be(mock_clip)
    end
  end

  describe "GET edit" do
    it "assigns the requested clip as @clip" do
      Clip.stub(:find).with("37") { mock_clip }
      get :edit, :id => "37"
      assigns(:clip).should be(mock_clip)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created clip as @clip" do
        Clip.stub(:new).with({'these' => 'params'}) { mock_clip(:save => true) }
        post :create, :clip => {'these' => 'params'}
        assigns(:clip).should be(mock_clip)
      end

      it "redirects to the created clip" do
        Clip.stub(:new) { mock_clip(:save => true) }
        post :create, :clip => {}
        response.should redirect_to(admin_clip_url(mock_clip))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved clip as @clip" do
        Clip.stub(:new).with({'these' => 'params'}) { mock_clip(:save => false) }
        post :create, :clip => {'these' => 'params'}
        assigns(:clip).should be(mock_clip)
      end

      it "re-renders the 'new' template" do
        Clip.stub(:new) { mock_clip(:save => false) }
        post :create, :clip => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested clip" do
        Clip.should_receive(:find).with("37") { mock_clip }
        mock_clip.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :clip => {'these' => 'params'}
      end

      it "assigns the requested clip as @clip" do
        Clip.stub(:find) { mock_clip(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:clip).should be(mock_clip)
      end

      it "redirects to the clip" do
        Clip.stub(:find) { mock_clip(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_clip_url(mock_clip))
      end
    end

    describe "with invalid params" do
      it "assigns the clip as @clip" do
        Clip.stub(:find) { mock_clip(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:clip).should be(mock_clip)
      end

      it "re-renders the 'edit' template" do
        Clip.stub(:find) { mock_clip(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested clip" do
      Clip.should_receive(:find).with("37") { mock_clip }
      mock_clip.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the clips list" do
      Clip.stub(:find) { mock_clip(:destroy => true) }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_clips_url)
    end
  end

end
