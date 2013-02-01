require 'spec_helper'

describe TyneCore::SprintsController do
  let(:user) do
    TyneAuth::User.create!(:name => "Foo", :username => "Foo", :uid => "foo", :token => "foo")
  end

  let(:project) do
    user.projects.create!(:key => "Foo", :name => "Foo")
  end

  let(:issue) do
    TyneCore::Issue.create!(:summary => "Foo", :project_id => project.id, :issue_type_id => 1)
  end

  context :logged_in do
    before :each do
      controller.stub(:current_user).and_return(user)
    end

    describe :index do
      before :each do
        get :index, :user => user.username, :key => project.key, :use_route => :tyne_core
      end

      it "assigns the list of all open sprints" do
        assigns(:sprints).should == project.sprints.not_running
        response.should be_success
      end
    end

    describe :create do
      before :each do
        post :create, :user => user.username, :key => project.key, :use_route => :tyne_core
      end

      it "should create a new sprint" do
        assigns(:sprint).name.should == 'Unnamed sprint'
        response.should be_success
      end
    end

    describe :update do
      let(:sprint) { project.sprints.create!(:name => "Foo") }

      before :each do
        put :update, :user => user.username, :key => project.key, :id => sprint.id, :sprint => { :name => "Bar" }, :use_route => :tyne_core, :format => :json
      end

      it "should create a new sprint" do
        assigns(:sprint).name.should == 'Bar'
        response.should be_success
      end
    end
  end
end
