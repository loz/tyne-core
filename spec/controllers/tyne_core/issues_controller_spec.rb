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
      it "should assign the list of the issues reported by the user" do
        get :index, :user => user.username, :key => project.key

        user.reported_issues.create!(:summary => "FOO", :description => "Foo", :issue_type_id => 1) do |issue|
          issue.project_id = project.id
        end
        assigns(:issues).should == project.issues.not_completed.order("created_at ASC")
      end

      it "should apply sort options when given" do
        get :index, :user => user.username, :key => project.key, :sorting => { :field => 'created_at', :order => 'desc' }

        user.reported_issues.create!(:summary => "FOO", :description => "Foo", :issue_type_id => 1) do |issue|
          issue.project_id = project.id
        end
        assigns(:issues).should == project.issues.not_completed.order("created_at DESC")

        # Fallback for field
        get :index, :user => user.username, :key => project.key, :sorting => { :field => 'foo', :order => 'asc' }
        assigns(:issues).should == project.issues.not_completed.order("id ASC")

        # Fallback for order
        get :index, :user => user.username, :key => project.key, :sorting => { :field => 'created_at', :order => 'foo' }
        assigns(:issues).should == project.issues.not_completed.order("created_at ASC")

        # Custom sorting
        get :index, :user => user.username, :key => project.key, :sorting => { :field => 'issue_type', :order => 'ASC' }
        assigns(:issues).should == project.issues.not_completed.joins(:issue_type).order("tyne_core_issue_types.name ASC")
      end

      it "render the correct view" do
        get :index, :user => user.username, :key => project.key

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
        get :edit, :user => user.username, :key => project.key, :id => issue.number
      end

      it "should render the correct view" do
        response.should render_template 'issues/edit'
      end
    end

    describe :update do
      before :each do
        put :update, :user => user.username, :key => project.key, :id => issue.number, :issue => { :summary => 'Bar' }
      end

      it "should update the issue" do
        issue.class.find_by_id(issue.id).summary.should == 'Bar'
      end
    end

    describe :workflow do
      context 'when a valid transition is given' do
        before :each do
          get :workflow, :user => user.username, :key => project.key, :id => issue.number, :transition => 'task_is_done'
        end

        it "should run the transition" do
          issue.class.find_by_id(issue.id).should be_completed
        end
      end

      context 'when an invalid transition is given' do
        before :each do
          get :workflow, :user => user.username, :key => project.key, :id => issue.number, :transition => 'foo'
        end

        it "should not run the transition" do
          issue.class.find_by_id(issue.id).should_not be_completed
          response.should_not be_success
        end
      end
    end

    describe :show do
      before :each do
        get :show, :user => user.username, :key => project.key, :id => issue.number
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
