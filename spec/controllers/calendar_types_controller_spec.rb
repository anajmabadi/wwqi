require 'spec_helper'

describe CalendarTypesController do

  def mock_calendar_type(stubs={})
    @mock_calendar_type ||= mock_model(CalendarType, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all calendar_types as @calendar_types" do
      CalendarType.stub(:all) { [mock_calendar_type] }
      get :index
      assigns(:calendar_types).should eq([mock_calendar_type])
    end
  end

  describe "GET show" do
    it "assigns the requested calendar_type as @calendar_type" do
      CalendarType.stub(:find).with("37") { mock_calendar_type }
      get :show, :id => "37"
      assigns(:calendar_type).should be(mock_calendar_type)
    end
  end

  describe "GET new" do
    it "assigns a new calendar_type as @calendar_type" do
      CalendarType.stub(:new) { mock_calendar_type }
      get :new
      assigns(:calendar_type).should be(mock_calendar_type)
    end
  end

  describe "GET edit" do
    it "assigns the requested calendar_type as @calendar_type" do
      CalendarType.stub(:find).with("37") { mock_calendar_type }
      get :edit, :id => "37"
      assigns(:calendar_type).should be(mock_calendar_type)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created calendar_type as @calendar_type" do
        CalendarType.stub(:new).with({'these' => 'params'}) { mock_calendar_type(:save => true) }
        post :create, :calendar_type => {'these' => 'params'}
        assigns(:calendar_type).should be(mock_calendar_type)
      end

      it "redirects to the created calendar_type" do
        CalendarType.stub(:new) { mock_calendar_type(:save => true) }
        post :create, :calendar_type => {}
        response.should redirect_to(calendar_type_url(mock_calendar_type))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved calendar_type as @calendar_type" do
        CalendarType.stub(:new).with({'these' => 'params'}) { mock_calendar_type(:save => false) }
        post :create, :calendar_type => {'these' => 'params'}
        assigns(:calendar_type).should be(mock_calendar_type)
      end

      it "re-renders the 'new' template" do
        CalendarType.stub(:new) { mock_calendar_type(:save => false) }
        post :create, :calendar_type => {}
        response.should render_template(:new)
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested calendar_type" do
        CalendarType.should_receive(:find).with("37") { mock_calendar_type }
        mock_calendar_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :calendar_type => {'these' => 'params'}
      end

      it "assigns the requested calendar_type as @calendar_type" do
        CalendarType.stub(:find) { mock_calendar_type(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:calendar_type).should be(mock_calendar_type)
      end

      it "redirects to the calendar_type" do
        CalendarType.stub(:find) { mock_calendar_type(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(calendar_type_url(mock_calendar_type))
      end
    end

    describe "with invalid params" do
      it "assigns the calendar_type as @calendar_type" do
        CalendarType.stub(:find) { mock_calendar_type(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:calendar_type).should be(mock_calendar_type)
      end

      it "re-renders the 'edit' template" do
        CalendarType.stub(:find) { mock_calendar_type(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template(:edit)
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested calendar_type" do
      CalendarType.should_receive(:find).with("37") { mock_calendar_type }
      mock_calendar_type.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the calendar_types list" do
      CalendarType.stub(:find) { mock_calendar_type(:destroy => true) }
      delete :destroy, :id => "1"
      response.should redirect_to(calendar_types_url)
    end
  end

end
