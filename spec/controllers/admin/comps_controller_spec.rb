require 'spec_helper'

describe Admin::CompsController do

  def mock_comp(stubs={})
    (@mock_comp ||= mock_model(Comp).as_null_object).tap do |comp|
      comp.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all comps as @comps" do
      Comp.stub(:all) { [mock_comp] }
      get :index
      assigns(:comps).should eq([mock_comp])
    end
  end

  describe "GET show" do
    it "assigns the requested comp as @comp" do
      Comp.stub(:find).with("37") { mock_comp }
      get :show, :id => "37"
      assigns(:comp).should be(mock_comp)
    end
  end

  describe "GET new" do
    it "assigns a new comp as @comp" do
      Comp.stub(:new) { mock_comp }
      get :new
      assigns(:comp).should be(mock_comp)
    end
  end

  describe "GET edit" do
    it "assigns the requested comp as @comp" do
      Comp.stub(:find).with("37") { mock_comp }
      get :edit, :id => "37"
      assigns(:comp).should be(mock_comp)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created comp as @comp" do
        Comp.stub(:new).with({'these' => 'params'}) { mock_comp(:save => true) }
        post :create, :comp => {'these' => 'params'}
        assigns(:comp).should be(mock_comp)
      end

      it "redirects to the created comp" do
        Comp.stub(:new) { mock_comp(:save => true) }
        post :create, :comp => {}
        response.should redirect_to(admin_comp_url(mock_comp))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved comp as @comp" do
        Comp.stub(:new).with({'these' => 'params'}) { mock_comp(:save => false) }
        post :create, :comp => {'these' => 'params'}
        assigns(:comp).should be(mock_comp)
      end

      it "re-renders the 'new' template" do
        Comp.stub(:new) { mock_comp(:save => false) }
        post :create, :comp => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested comp" do
        Comp.should_receive(:find).with("37") { mock_comp }
        mock_comp.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :comp => {'these' => 'params'}
      end

      it "assigns the requested comp as @comp" do
        Comp.stub(:find) { mock_comp(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:comp).should be(mock_comp)
      end

      it "redirects to the comp" do
        Comp.stub(:find) { mock_comp(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_comp_url(mock_comp))
      end
    end

    describe "with invalid params" do
      it "assigns the comp as @comp" do
        Comp.stub(:find) { mock_comp(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:comp).should be(mock_comp)
      end

      it "re-renders the 'edit' template" do
        Comp.stub(:find) { mock_comp(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested comp" do
      Comp.should_receive(:find).with("37") { mock_comp }
      mock_comp.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the comps list" do
      Comp.stub(:find) { mock_comp }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_comps_url)
    end
  end

end
