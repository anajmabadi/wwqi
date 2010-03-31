require 'spec_helper'

describe RelationshipsController do

  def mock_relationship(stubs={})
    @mock_relationship ||= mock_model(Relationship, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all relationships as @relationships" do
      Relationship.stub(:all) { [mock_relationship] }
      get :index
      assigns(:relationships).should eq([mock_relationship])
    end
  end

  describe "GET show" do
    it "assigns the requested relationship as @relationship" do
      Relationship.stub(:find).with("37") { mock_relationship }
      get :show, :id => "37"
      assigns(:relationship).should be(mock_relationship)
    end
  end

  describe "GET new" do
    it "assigns a new relationship as @relationship" do
      Relationship.stub(:new) { mock_relationship }
      get :new
      assigns(:relationship).should be(mock_relationship)
    end
  end

  describe "GET edit" do
    it "assigns the requested relationship as @relationship" do
      Relationship.stub(:find).with("37") { mock_relationship }
      get :edit, :id => "37"
      assigns(:relationship).should be(mock_relationship)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created relationship as @relationship" do
        Relationship.stub(:new).with({'these' => 'params'}) { mock_relationship(:save => true) }
        post :create, :relationship => {'these' => 'params'}
        assigns(:relationship).should be(mock_relationship)
      end

      it "redirects to the created relationship" do
        Relationship.stub(:new) { mock_relationship(:save => true) }
        post :create, :relationship => {}
        response.should redirect_to(relationship_url(mock_relationship))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved relationship as @relationship" do
        Relationship.stub(:new).with({'these' => 'params'}) { mock_relationship(:save => false) }
        post :create, :relationship => {'these' => 'params'}
        assigns(:relationship).should be(mock_relationship)
      end

      it "re-renders the 'new' template" do
        Relationship.stub(:new) { mock_relationship(:save => false) }
        post :create, :relationship => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested relationship" do
        Relationship.should_receive(:find).with("37") { mock_relationship }
        mock_relationship.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :relationship => {'these' => 'params'}
      end

      it "assigns the requested relationship as @relationship" do
        Relationship.stub(:find) { mock_relationship(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:relationship).should be(mock_relationship)
      end

      it "redirects to the relationship" do
        Relationship.stub(:find) { mock_relationship(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(relationship_url(mock_relationship))
      end
    end

    describe "with invalid params" do
      it "assigns the relationship as @relationship" do
        Relationship.stub(:find) { mock_relationship(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:relationship).should be(mock_relationship)
      end

      it "re-renders the 'edit' template" do
        Relationship.stub(:find) { mock_relationship(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested relationship" do
      Relationship.should_receive(:find).with("37") { mock_relationship }
      mock_relationship.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the relationships list" do
      Relationship.stub(:find) { mock_relationship(:destroy => true) }
      delete :destroy, :id => "1"
      response.should redirect_to(relationships_url)
    end
  end

end
