require 'spec_helper'

describe FormatsController do

  def mock_format(stubs={})
    @mock_format ||= mock_model(Format, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all formats as @formats" do
      Format.stub(:all) { [mock_format] }
      get :index
      assigns(:formats).should eq([mock_format])
    end
  end

  describe "GET show" do
    it "assigns the requested format as @format" do
      Format.stub(:find).with("37") { mock_format }
      get :show, :id => "37"
      assigns(:format).should be(mock_format)
    end
  end

  describe "GET new" do
    it "assigns a new format as @format" do
      Format.stub(:new) { mock_format }
      get :new
      assigns(:format).should be(mock_format)
    end
  end

  describe "GET edit" do
    it "assigns the requested format as @format" do
      Format.stub(:find).with("37") { mock_format }
      get :edit, :id => "37"
      assigns(:format).should be(mock_format)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created format as @format" do
        Format.stub(:new).with({'these' => 'params'}) { mock_format(:save => true) }
        post :create, :format => {'these' => 'params'}
        assigns(:format).should be(mock_format)
      end

      it "redirects to the created format" do
        Format.stub(:new) { mock_format(:save => true) }
        post :create, :format => {}
        response.should redirect_to(format_url(mock_format))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved format as @format" do
        Format.stub(:new).with({'these' => 'params'}) { mock_format(:save => false) }
        post :create, :format => {'these' => 'params'}
        assigns(:format).should be(mock_format)
      end

      it "re-renders the 'new' template" do
        Format.stub(:new) { mock_format(:save => false) }
        post :create, :format => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested format" do
        Format.should_receive(:find).with("37") { mock_format }
        mock_format.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :format => {'these' => 'params'}
      end

      it "assigns the requested format as @format" do
        Format.stub(:find) { mock_format(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:format).should be(mock_format)
      end

      it "redirects to the format" do
        Format.stub(:find) { mock_format(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(format_url(mock_format))
      end
    end

    describe "with invalid params" do
      it "assigns the format as @format" do
        Format.stub(:find) { mock_format(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:format).should be(mock_format)
      end

      it "re-renders the 'edit' template" do
        Format.stub(:find) { mock_format(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested format" do
      Format.should_receive(:find).with("37") { mock_format }
      mock_format.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the formats list" do
      Format.stub(:find) { mock_format(:destroy => true) }
      delete :destroy, :id => "1"
      response.should redirect_to(formats_url)
    end
  end

end
