require 'spec_helper'

describe TranslationsController do

  def mock_translation(stubs={})
    @mock_translation ||= mock_model(Translation, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all translations as @translations" do
      Translation.stub(:all) { [mock_translation] }
      get :index
      assigns(:translations).should eq([mock_translation])
    end
  end

  describe "GET show" do
    it "assigns the requested translation as @translation" do
      Translation.stub(:find).with("37") { mock_translation }
      get :show, :id => "37"
      assigns(:translation).should be(mock_translation)
    end
  end

  describe "GET new" do
    it "assigns a new translation as @translation" do
      Translation.stub(:new) { mock_translation }
      get :new
      assigns(:translation).should be(mock_translation)
    end
  end

  describe "GET edit" do
    it "assigns the requested translation as @translation" do
      Translation.stub(:find).with("37") { mock_translation }
      get :edit, :id => "37"
      assigns(:translation).should be(mock_translation)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created translation as @translation" do
        Translation.stub(:new).with({'these' => 'params'}) { mock_translation(:save => true) }
        post :create, :translation => {'these' => 'params'}
        assigns(:translation).should be(mock_translation)
      end

      it "redirects to the created translation" do
        Translation.stub(:new) { mock_translation(:save => true) }
        post :create, :translation => {}
        response.should redirect_to(translation_url(mock_translation))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved translation as @translation" do
        Translation.stub(:new).with({'these' => 'params'}) { mock_translation(:save => false) }
        post :create, :translation => {'these' => 'params'}
        assigns(:translation).should be(mock_translation)
      end

      it "re-renders the 'new' template" do
        Translation.stub(:new) { mock_translation(:save => false) }
        post :create, :translation => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested translation" do
        Translation.should_receive(:find).with("37") { mock_translation }
        mock_translation.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :translation => {'these' => 'params'}
      end

      it "assigns the requested translation as @translation" do
        Translation.stub(:find) { mock_translation(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:translation).should be(mock_translation)
      end

      it "redirects to the translation" do
        Translation.stub(:find) { mock_translation(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(translation_url(mock_translation))
      end
    end

    describe "with invalid params" do
      it "assigns the translation as @translation" do
        Translation.stub(:find) { mock_translation(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:translation).should be(mock_translation)
      end

      it "re-renders the 'edit' template" do
        Translation.stub(:find) { mock_translation(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested translation" do
      Translation.should_receive(:find).with("37") { mock_translation }
      mock_translation.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the translations list" do
      Translation.stub(:find) { mock_translation(:destroy => true) }
      delete :destroy, :id => "1"
      response.should redirect_to(translations_url)
    end
  end

end
