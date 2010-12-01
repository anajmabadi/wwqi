require 'spec_helper'

describe ErasController do

  def mock_era(stubs={})
    (@mock_era ||= mock_model(Era).as_null_object).tap do |era|
      era.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all eras as @eras" do
      Era.stub(:all) { [mock_era] }
      get :index
      assigns(:eras).should eq([mock_era])
    end
  end

  describe "GET show" do
    it "assigns the requested era as @era" do
      Era.stub(:find).with("37") { mock_era }
      get :show, :id => "37"
      assigns(:era).should be(mock_era)
    end
  end

  describe "GET new" do
    it "assigns a new era as @era" do
      Era.stub(:new) { mock_era }
      get :new
      assigns(:era).should be(mock_era)
    end
  end

  describe "GET edit" do
    it "assigns the requested era as @era" do
      Era.stub(:find).with("37") { mock_era }
      get :edit, :id => "37"
      assigns(:era).should be(mock_era)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created era as @era" do
        Era.stub(:new).with({'these' => 'params'}) { mock_era(:save => true) }
        post :create, :era => {'these' => 'params'}
        assigns(:era).should be(mock_era)
      end

      it "redirects to the created era" do
        Era.stub(:new) { mock_era(:save => true) }
        post :create, :era => {}
        response.should redirect_to(era_url(mock_era))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved era as @era" do
        Era.stub(:new).with({'these' => 'params'}) { mock_era(:save => false) }
        post :create, :era => {'these' => 'params'}
        assigns(:era).should be(mock_era)
      end

      it "re-renders the 'new' template" do
        Era.stub(:new) { mock_era(:save => false) }
        post :create, :era => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested era" do
        Era.should_receive(:find).with("37") { mock_era }
        mock_era.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :era => {'these' => 'params'}
      end

      it "assigns the requested era as @era" do
        Era.stub(:find) { mock_era(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:era).should be(mock_era)
      end

      it "redirects to the era" do
        Era.stub(:find) { mock_era(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(era_url(mock_era))
      end
    end

    describe "with invalid params" do
      it "assigns the era as @era" do
        Era.stub(:find) { mock_era(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:era).should be(mock_era)
      end

      it "re-renders the 'edit' template" do
        Era.stub(:find) { mock_era(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested era" do
      Era.should_receive(:find).with("37") { mock_era }
      mock_era.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the eras list" do
      Era.stub(:find) { mock_era }
      delete :destroy, :id => "1"
      response.should redirect_to(eras_url)
    end
  end

end
