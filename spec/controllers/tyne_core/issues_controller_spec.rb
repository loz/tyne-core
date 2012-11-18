require 'spec_helper'

describe TyneCore::IssuesController do
  context :not_logged_in do
    it "should not allow any actions" do
      get :index, :user => "Foo", :key => "Foo"
      response.should redirect_to login_path
    end
  end

  context :logged_in do
    let(:user) do
      TyneAuth::User.create!(:name => "Foo", :username => "Foo", :uid => "foo", :token => "foo")
    end

    let(:project) do
      user.projects.create!(:key => "Foo", :name => "Foo")
    end

    let(:issue) do
      TyneCore::Issue.create!(:summary => "Foo", :project_id => project.id, :issue_type_id => 1)
    end

    before :each do
      controller.stub(:current_user).and_return(user)
    end

    describe :index do
      before :each do
        get :index, :user => user.username, :key => project.key
      end

      it "should assign the list of the issues reported by the user" do
        user.reported_issues.create!(:summary => "FOO", :description => "Foo", :issue_type_id => 1) do |issue|
          issue.project_id = project.id
        end
        assigns(:issues).should == project.issues.not_completed
      end

      it "render the correct view" do
        response.should render_template "issues/index"
      end
    end

    describe :create do
      before :each do
        post :create, :user => user.username, :key => project.key, :issue => { :summary => "Foo", :description => "Bar", :project_id => project.id, :issue_type_id => 1 }
      end

      it "should create a new issue" do
        TyneCore::Issue.find_by_summary("Foo").reported_by.should == user
      end
    end

    describe :new do
      before :each do
        get :new, :user => user.username, :key => project.key
      end

      it "should render the correct view" do
        response.should render_template 'issues/new'
      end
    end

    describe :edit do
      before :each do
        get :edit, :user => user.username, :key => project.key, :id => issue.id
      end

      it "should render the correct view" do
        response.should render_template 'issues/edit'
      end
    end

    describe :update do
      before :each do
        put :update, :user => user.username, :key => project.key, :id => issue.id, :issue => { :summary => 'Bar' }
      end

      it "should update the issue" do
        issue.class.find_by_id(issue.id).summary.should == 'Bar'
      end
    end

    describe :show do
      before :each do
        get :show, :user => user.username, :key => project.key, :id => issue.id
      end

      it "should render the correct view" do
        assigns(:issue).should == issue
        response.should render_template "issues/show"
      end
    end

    describe :dialog do
      before :each do
        get :dialog, :user => user.username, :key => project.key, :format => :pjax
      end

      it "should render the correct view" do
        response.should render_template "issues/dialog"
      end
    end
  end
end
