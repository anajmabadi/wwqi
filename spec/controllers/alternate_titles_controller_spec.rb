require 'spec_helper'

describe AlternateTitlesController do

  def mock_alternate_title(stubs={})
    (@mock_alternate_title ||= mock_model(AlternateTitle).as_null_object).tap do |alternate_title|
      alternate_title.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all alternate_titles as @alternate_titles" do
      AlternateTitle.stub(:all) { [mock_alternate_title] }
      get :index
      assigns(:alternate_titles).should eq([mock_alternate_title])
    end
  end

  describe "GET show" do
    it "assigns the requested alternate_title as @alternate_title" do
      AlternateTitle.stub(:find).with("37") { mock_alternate_title }
      get :show, :id => "37"
      assigns(:alternate_title).should be(mock_alternate_title)
    end
  end

  describe "GET new" do
    it "assigns a new alternate_title as @alternate_title" do
      AlternateTitle.stub(:new) { mock_alternate_title }
      get :new
      assigns(:alternate_title).should be(mock_alternate_title)
    end
  end

  describe "GET edit" do
    it "assigns the requested alternate_title as @alternate_title" do
      AlternateTitle.stub(:find).with("37") { mock_alternate_title }
      get :edit, :id => "37"
      assigns(:alternate_title).should be(mock_alternate_title)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created alternate_title as @alternate_title" do
        AlternateTitle.stub(:new).with({'these' => 'params'}) { mock_alternate_title(:save => true) }
        post :create, :alternate_title => {'these' => 'params'}
        assigns(:alternate_title).should be(mock_alternate_title)
      end

      it "redirects to the created alternate_title" do
        AlternateTitle.stub(:new) { mock_alternate_title(:save => true) }
        post :create, :alternate_title => {}
        response.should redirect_to(alternate_title_url(mock_alternate_title))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved alternate_title as @alternate_title" do
        AlternateTitle.stub(:new).with({'these' => 'params'}) { mock_alternate_title(:save => false) }
        post :create, :alternate_title => {'these' => 'params'}
        assigns(:alternate_title).should be(mock_alternate_title)
      end

      it "re-renders the 'new' template" do
        AlternateTitle.stub(:new) { mock_alternate_title(:save => false) }
        post :create, :alternate_title => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested alternate_title" do
        AlternateTitle.should_receive(:find).with("37") { mock_alternate_title }
        mock_alternate_title.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :alternate_title => {'these' => 'params'}
      end

      it "assigns the requested alternate_title as @alternate_title" do
        AlternateTitle.stub(:find) { mock_alternate_title(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:alternate_title).should be(mock_alternate_title)
      end

      it "redirects to the alternate_title" do
        AlternateTitle.stub(:find) { mock_alternate_title(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(alternate_title_url(mock_alternate_title))
      end
    end

    describe "with invalid params" do
      it "assigns the alternate_title as @alternate_title" do
        AlternateTitle.stub(:find) { mock_alternate_title(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:alternate_title).should be(mock_alternate_title)
      end

      it "re-renders the 'edit' template" do
        AlternateTitle.stub(:find) { mock_alternate_title(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested alternate_title" do
      AlternateTitle.should_receive(:find).with("37") { mock_alternate_title }
      mock_alternate_title.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the alternate_titles list" do
      AlternateTitle.stub(:find) { mock_alternate_title }
      delete :destroy, :id => "1"
      response.should redirect_to(alternate_titles_url)
    end
  end

end
