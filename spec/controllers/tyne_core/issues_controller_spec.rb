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
        get :index, :project_id => project.id, :use_route => :tyne_core
      end

      it "should assign the list of the issues reported by the user" do
        user.reported_issues.create!(:summary => "FOO", :description => "Foo") do |issue|
          issue.project_id = project.id
        end
        assigns(:issues).should == user.reported_issues
        assigns(:project).should == project
      end

      it "render the correct view" do
        response.should render_template "issues/index"
      end
    end
  end
end
