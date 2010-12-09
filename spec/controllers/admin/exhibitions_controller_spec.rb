require 'spec_helper'

describe Admin::ExhibitionsController do

  def mock_exhibition(stubs={})
    @mock_exhibition ||= mock_model(Exhibition, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all exhibitions as @exhibitions" do
      Exhibition.stub(:all) { [mock_exhibition] }
      get :index
      assigns(:exhibitions).should eq([mock_exhibition])
    end
  end

  describe "GET show" do
    it "assigns the requested exhibition as @exhibition" do
      Exhibition.stub(:find).with("37") { mock_exhibition }
      get :show, :id => "37"
      assigns(:exhibition).should be(mock_exhibition)
    end
  end

  describe "GET new" do
    it "assigns a new exhibition as @exhibition" do
      Exhibition.stub(:new) { mock_exhibition }
      get :new
      assigns(:exhibition).should be(mock_exhibition)
    end
  end

  describe "GET edit" do
    it "assigns the requested exhibition as @exhibition" do
      Exhibition.stub(:find).with("37") { mock_exhibition }
      get :edit, :id => "37"
      assigns(:exhibition).should be(mock_exhibition)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created exhibition as @exhibition" do
        Exhibition.stub(:new).with({'these' => 'params'}) { mock_exhibition(:save => true) }
        post :create, :exhibition => {'these' => 'params'}
        assigns(:exhibition).should be(mock_exhibition)
      end

      it "redirects to the created exhibition" do
        Exhibition.stub(:new) { mock_exhibition(:save => true) }
        post :create, :exhibition => {}
        response.should redirect_to(admin_exhibition_url(mock_exhibition))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved exhibition as @exhibition" do
        Exhibition.stub(:new).with({'these' => 'params'}) { mock_exhibition(:save => false) }
        post :create, :exhibition => {'these' => 'params'}
        assigns(:exhibition).should be(mock_exhibition)
      end

      it "re-renders the 'new' template" do
        Exhibition.stub(:new) { mock_exhibition(:save => false) }
        post :create, :exhibition => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested exhibition" do
        Exhibition.should_receive(:find).with("37") { mock_exhibition }
        mock_exhibition.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :exhibition => {'these' => 'params'}
      end

      it "assigns the requested exhibition as @exhibition" do
        Exhibition.stub(:find) { mock_exhibition(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:exhibition).should be(mock_exhibition)
      end

      it "redirects to the exhibition" do
        Exhibition.stub(:find) { mock_exhibition(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_exhibition_url(mock_exhibition))
      end
    end

    describe "with invalid params" do
      it "assigns the exhibition as @exhibition" do
        Exhibition.stub(:find) { mock_exhibition(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:exhibition).should be(mock_exhibition)
      end

      it "re-renders the 'edit' template" do
        Exhibition.stub(:find) { mock_exhibition(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested exhibition" do
      Exhibition.should_receive(:find).with("37") { mock_exhibition }
      mock_exhibition.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the exhibitions list" do
      Exhibition.stub(:find) { mock_exhibition(:destroy => true) }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_exhibitions_url)
    end
  end

end
