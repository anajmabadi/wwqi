require 'spec_helper'

describe MediaController do

  def mock_medium(stubs={})
    @mock_medium ||= mock_model(Medium, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all medias as @medias" do
      Medium.stub(:all) { [mock_medium] }
      get :index
      assigns(:media).should eq([mock_medium])
    end
  end

  describe "GET show" do
    it "assigns the requested medium as @medium" do
      Medium.stub(:find).with("37") { mock_medium }
      get :show, :id => "37"
      assigns(:medium).should be(mock_medium)
    end
  end

  describe "GET new" do
    it "assigns a new medium as @medium" do
      Medium.stub(:new) { mock_medium }
      get :new
      assigns(:medium).should be(mock_medium)
    end
  end

  describe "GET edit" do
    it "assigns the requested medium as @medium" do
      Medium.stub(:find).with("37") { mock_medium }
      get :edit, :id => "37"
      assigns(:medium).should be(mock_medium)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created medium as @medium" do
        Medium.stub(:new).with({'these' => 'params'}) { mock_medium(:save => true) }
        post :create, :medium => {'these' => 'params'}
        assigns(:medium).should be(mock_medium)
      end

      it "redirects to the created medium" do
        Medium.stub(:new) { mock_medium(:save => true) }
        post :create, :medium => {}
        response.should redirect_to(medium_url(mock_medium))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved medium as @medium" do
        Medium.stub(:new).with({'these' => 'params'}) { mock_medium(:save => false) }
        post :create, :medium => {'these' => 'params'}
        assigns(:medium).should be(mock_medium)
      end

      it "re-renders the 'new' template" do
        Medium.stub(:new) { mock_medium(:save => false) }
        post :create, :medium => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested medium" do
        Medium.should_receive(:find).with("37") { mock_medium }
        mock_medium.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :medium => {'these' => 'params'}
      end

      it "assigns the requested medium as @medium" do
        Medium.stub(:find) { mock_medium(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:medium).should be(mock_medium)
      end

      it "redirects to the medium" do
        Medium.stub(:find) { mock_medium(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(medium_url(mock_medium))
      end
    end

    describe "with invalid params" do
      it "assigns the medium as @medium" do
        Medium.stub(:find) { mock_medium(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:medium).should be(mock_medium)
      end

      it "re-renders the 'edit' template" do
        Medium.stub(:find) { mock_medium(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested medium" do
      Medium.should_receive(:find).with("37") { mock_medium }
      mock_medium.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the media list" do
      Medium.stub(:find) { mock_medium(:destroy => true) }
      delete :destroy, :id => "1"
      response.should redirect_to(media_url)
    end
  end

end
