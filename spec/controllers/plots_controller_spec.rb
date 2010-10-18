require 'spec_helper'

describe PlotsController do

  def mock_plot(stubs={})
    @mock_plot ||= mock_model(Plot, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all plots as @plots" do
      Plot.stub(:all) { [mock_plot] }
      get :index
      assigns(:plots).should eq([mock_plot])
    end
  end

  describe "GET show" do
    it "assigns the requested plot as @plot" do
      Plot.stub(:find).with("37") { mock_plot }
      get :show, :id => "37"
      assigns(:plot).should be(mock_plot)
    end
  end

  describe "GET new" do
    it "assigns a new plot as @plot" do
      Plot.stub(:new) { mock_plot }
      get :new
      assigns(:plot).should be(mock_plot)
    end
  end

  describe "GET edit" do
    it "assigns the requested plot as @plot" do
      Plot.stub(:find).with("37") { mock_plot }
      get :edit, :id => "37"
      assigns(:plot).should be(mock_plot)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created plot as @plot" do
        Plot.stub(:new).with({'these' => 'params'}) { mock_plot(:save => true) }
        post :create, :plot => {'these' => 'params'}
        assigns(:plot).should be(mock_plot)
      end

      it "redirects to the created plot" do
        Plot.stub(:new) { mock_plot(:save => true) }
        post :create, :plot => {}
        response.should redirect_to(plot_url(mock_plot))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved plot as @plot" do
        Plot.stub(:new).with({'these' => 'params'}) { mock_plot(:save => false) }
        post :create, :plot => {'these' => 'params'}
        assigns(:plot).should be(mock_plot)
      end

      it "re-renders the 'new' template" do
        Plot.stub(:new) { mock_plot(:save => false) }
        post :create, :plot => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested plot" do
        Plot.should_receive(:find).with("37") { mock_plot }
        mock_plot.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :plot => {'these' => 'params'}
      end

      it "assigns the requested plot as @plot" do
        Plot.stub(:find) { mock_plot(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:plot).should be(mock_plot)
      end

      it "redirects to the plot" do
        Plot.stub(:find) { mock_plot(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(plot_url(mock_plot))
      end
    end

    describe "with invalid params" do
      it "assigns the plot as @plot" do
        Plot.stub(:find) { mock_plot(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:plot).should be(mock_plot)
      end

      it "re-renders the 'edit' template" do
        Plot.stub(:find) { mock_plot(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested plot" do
      Plot.should_receive(:find).with("37") { mock_plot }
      mock_plot.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the plots list" do
      Plot.stub(:find) { mock_plot }
      delete :destroy, :id => "1"
      response.should redirect_to(plots_url)
    end
  end

end
