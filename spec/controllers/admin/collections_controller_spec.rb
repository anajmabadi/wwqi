require 'spec_helper'

describe Admin::CollectionsController do

  def mock_collection(stubs={})
    @mock_collection ||= mock_model(Collection, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all collections as @collections" do
      Collection.stub(:all) { [mock_collection] }
      get :index
      assigns(:collections).should eq([mock_collection])
    end
  end

  describe "GET show" do
    it "assigns the requested collection as @collection" do
      Collection.stub(:find).with("37") { mock_collection }
      get :show, :id => "37"
      assigns(:collection).should be(mock_collection)
    end
  end

  describe "GET new" do
    it "assigns a new collection as @collection" do
      Collection.stub(:new) { mock_collection }
      get :new
      assigns(:collection).should be(mock_collection)
    end
  end

  describe "GET edit" do
    it "assigns the requested collection as @collection" do
      Collection.stub(:find).with("37") { mock_collection }
      get :edit, :id => "37"
      assigns(:collection).should be(mock_collection)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created collection as @collection" do
        Collection.stub(:new).with({'these' => 'params'}) { mock_collection(:save => true) }
        post :create, :collection => {'these' => 'params'}
        assigns(:collection).should be(mock_collection)
      end

      it "redirects to the created collection" do
        Collection.stub(:new) { mock_collection(:save => true) }
        post :create, :collection => {}
        response.should redirect_to(admin_collection_url(mock_collection))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved collection as @collection" do
        Collection.stub(:new).with({'these' => 'params'}) { mock_collection(:save => false) }
        post :create, :collection => {'these' => 'params'}
        assigns(:collection).should be(mock_collection)
      end

      it "re-renders the 'new' template" do
        Collection.stub(:new) { mock_collection(:save => false) }
        post :create, :collection => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested collection" do
        Collection.should_receive(:find).with("37") { mock_collection }
        mock_collection.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :collection => {'these' => 'params'}
      end

      it "assigns the requested collection as @collection" do
        Collection.stub(:find) { mock_collection(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:collection).should be(mock_collection)
      end

      it "redirects to the collection" do
        Collection.stub(:find) { mock_collection(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_collection_url(mock_collection))
      end
    end

    describe "with invalid params" do
      it "assigns the collection as @collection" do
        Collection.stub(:find) { mock_collection(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:collection).should be(mock_collection)
      end

      it "re-renders the 'edit' template" do
        Collection.stub(:find) { mock_collection(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested collection" do
      Collection.should_receive(:find).with("37") { mock_collection }
      mock_collection.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the collections list" do
      Collection.stub(:find) { mock_collection(:destroy => true) }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_collections_url)
    end
  end

end
