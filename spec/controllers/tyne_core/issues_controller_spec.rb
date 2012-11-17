require 'spec_helper'

describe TyneCore::IssuesController do
  before(:each) { @routes = TyneCore::Engine.routes }

  context :not_logged_in do
    it "should not allow any actions" do
      get :index, :project_id => 1, :use_route => :tyne_core
      response.should redirect_to login_path
    end
  end

  context :logged_in do
    let(:user) do
      TyneAuth::User.create!(:name => "Foo", :uid => "foo", :token => "foo")
    end

    let(:project) do
      user.projects.create!(:key => "Foo", :name => "Foo")
    end

    before :each do
      controller.stub(:current_user).and_return(user)
    end

    describe :index do
      before :each do
        get :index, :filter => { :project_id => project.id }, :use_route => :tyne_core
      end

      it "should assign the list of the issues reported by the user" do
        user.reported_issues.create!(:summary => "FOO", :description => "Foo") do |issue|
          issue.project_id = project.id
        end
        assigns(:issues).should == TyneCore::Issue.where(:project_id => project.id)
      end

      it "render the correct view" do
        response.should render_template "issues/index"
      end
    end

    describe :show do
      before :each do
        post :create, :issue => { :summary => "Foo", :description => "Bar", :project_id => project.id }
      end

      it "should create a new issue" do
        TyneCore::Issue.find_by_summary("Foo").reported_by.should == user
      end
    end

    describe :new do
      before :each do
        get :new
      end

      it "should render the correct view" do
        response.should render_template 'issues/new'
      end
    end

    describe :show do
      let(:issue) { TyneCore::Issue.create!(:summary => "Foo", :project_id => project.id) }

      before :each do
        get :show, :id => issue.id
      end

      it "should render the correct view" do
        assigns(:issue).should == issue
        response.should render_template "issues/show"
      end
    end

    describe :dialog do
      before :each do
        get :dialog, :format => :pjax
      end

      it "should render the correct view" do
        response.should render_template "issues/dialog"
      end
    end
  end
end
