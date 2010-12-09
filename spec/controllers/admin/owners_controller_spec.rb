require 'spec_helper'

describe Admin::OwnersController do

  def mock_owner(stubs={})
    @mock_owner ||= mock_model(Owner, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all owners as @owners" do
      Owner.stub(:all) { [mock_owner] }
      get :index
      assigns(:owners).should eq([mock_owner])
    end
  end

  describe "GET show" do
    it "assigns the requested owner as @owner" do
      Owner.stub(:find).with("37") { mock_owner }
      get :show, :id => "37"
      assigns(:owner).should be(mock_owner)
    end
  end

  describe "GET new" do
    it "assigns a new owner as @owner" do
      Owner.stub(:new) { mock_owner }
      get :new
      assigns(:owner).should be(mock_owner)
    end
  end

  describe "GET edit" do
    it "assigns the requested owner as @owner" do
      Owner.stub(:find).with("37") { mock_owner }
      get :edit, :id => "37"
      assigns(:owner).should be(mock_owner)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created owner as @owner" do
        Owner.stub(:new).with({'these' => 'params'}) { mock_owner(:save => true) }
        post :create, :owner => {'these' => 'params'}
        assigns(:owner).should be(mock_owner)
      end

      it "redirects to the created owner" do
        Owner.stub(:new) { mock_owner(:save => true) }
        post :create, :owner => {}
        response.should redirect_to(admin_owner_url(mock_owner))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved owner as @owner" do
        Owner.stub(:new).with({'these' => 'params'}) { mock_owner(:save => false) }
        post :create, :owner => {'these' => 'params'}
        assigns(:owner).should be(mock_owner)
      end

      it "re-renders the 'new' template" do
        Owner.stub(:new) { mock_owner(:save => false) }
        post :create, :owner => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested owner" do
        Owner.should_receive(:find).with("37") { mock_owner }
        mock_owner.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :owner => {'these' => 'params'}
      end

      it "assigns the requested owner as @owner" do
        Owner.stub(:find) { mock_owner(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:owner).should be(mock_owner)
      end

      it "redirects to the owner" do
        Owner.stub(:find) { mock_owner(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_owner_url(mock_owner))
      end
    end

    describe "with invalid params" do
      it "assigns the owner as @owner" do
        Owner.stub(:find) { mock_owner(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:owner).should be(mock_owner)
      end

      it "re-renders the 'edit' template" do
        Owner.stub(:find) { mock_owner(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested owner" do
      Owner.should_receive(:find).with("37") { mock_owner }
      mock_owner.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the owners list" do
      Owner.stub(:find) { mock_owner(:destroy => true) }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_owners_url)
    end
  end

end
