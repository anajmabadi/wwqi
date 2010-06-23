require 'spec_helper'

describe SubjectTypesController do

  def mock_subject_type(stubs={})
    @mock_subject_type ||= mock_model(SubjectType, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all subject_types as @subject_types" do
      SubjectType.stub(:all) { [mock_subject_type] }
      get :index
      assigns(:subject_types).should eq([mock_subject_type])
    end
  end

  describe "GET show" do
    it "assigns the requested subject_type as @subject_type" do
      SubjectType.stub(:find).with("37") { mock_subject_type }
      get :show, :id => "37"
      assigns(:subject_type).should be(mock_subject_type)
    end
  end

  describe "GET new" do
    it "assigns a new subject_type as @subject_type" do
      SubjectType.stub(:new) { mock_subject_type }
      get :new
      assigns(:subject_type).should be(mock_subject_type)
    end
  end

  describe "GET edit" do
    it "assigns the requested subject_type as @subject_type" do
      SubjectType.stub(:find).with("37") { mock_subject_type }
      get :edit, :id => "37"
      assigns(:subject_type).should be(mock_subject_type)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created subject_type as @subject_type" do
        SubjectType.stub(:new).with({'these' => 'params'}) { mock_subject_type(:save => true) }
        post :create, :subject_type => {'these' => 'params'}
        assigns(:subject_type).should be(mock_subject_type)
      end

      it "redirects to the created subject_type" do
        SubjectType.stub(:new) { mock_subject_type(:save => true) }
        post :create, :subject_type => {}
        response.should redirect_to(subject_type_url(mock_subject_type))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved subject_type as @subject_type" do
        SubjectType.stub(:new).with({'these' => 'params'}) { mock_subject_type(:save => false) }
        post :create, :subject_type => {'these' => 'params'}
        assigns(:subject_type).should be(mock_subject_type)
      end

      it "re-renders the 'new' template" do
        SubjectType.stub(:new) { mock_subject_type(:save => false) }
        post :create, :subject_type => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested subject_type" do
        SubjectType.should_receive(:find).with("37") { mock_subject_type }
        mock_subject_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :subject_type => {'these' => 'params'}
      end

      it "assigns the requested subject_type as @subject_type" do
        SubjectType.stub(:find) { mock_subject_type(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:subject_type).should be(mock_subject_type)
      end

      it "redirects to the subject_type" do
        SubjectType.stub(:find) { mock_subject_type(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(subject_type_url(mock_subject_type))
      end
    end

    describe "with invalid params" do
      it "assigns the subject_type as @subject_type" do
        SubjectType.stub(:find) { mock_subject_type(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:subject_type).should be(mock_subject_type)
      end

      it "re-renders the 'edit' template" do
        SubjectType.stub(:find) { mock_subject_type(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested subject_type" do
      SubjectType.should_receive(:find).with("37") { mock_subject_type }
      mock_subject_type.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the subject_types list" do
      SubjectType.stub(:find) { mock_subject_type(:destroy => true) }
      delete :destroy, :id => "1"
      response.should redirect_to(subject_types_url)
    end
  end

end
