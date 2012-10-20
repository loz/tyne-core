require 'spec_helper'

describe TyneCore::ProjectsController do
  before(:each) { @routes = TyneCore::Engine.routes }

  context :not_logged_in do
    it "should not allows any actions" do
      get :index, :use_route => :tyne_core
      response.should redirect_to login_path

      post :create, :use_route => :tyne_core
      response.should redirect_to login_path

      delete :destroy, :id => 1, :use_route => :tyne_core
      response.should redirect_to login_path

      get :github, :use_route => :tyne_core
      response.should redirect_to login_path

      post :import, :use_route => :tyne_core
      response.should redirect_to login_path
    end
  end

  context :logged_in do
    let(:user) do
      TyneAuth::User.new
    end

    before :each do
      controller.stub(:current_user).and_return(user)
    end

    describe :index do
      before :each do
        get :index, :use_route => :tyne_core
      end

      it "should assign the list of all projects" do
        assigns(:project).should be_new_record
        assigns(:projects).should == TyneCore::Project.all
      end

      it "should render the correct view" do
        response.should render_template "projects/index"
      end
    end

    describe :create do
      context :success do
        before :each do
          post :create, :project => { :key => "FOO", :name => "Foo" }, :use_route => :tyne_core
        end

        it "should create a new project" do
          TyneCore::Project.find_by_key("FOO").should be_present
        end

        it "should render the correct view" do
          response.should render_template "projects/_project"
        end
      end

      context :failure do
        xit "should return the error message" do
          post :create, :use_route => :tyne_core

          response.should_not be_success
        end
      end
    end

    describe :update do
      context :success do
        let(:existing) do
          TyneCore::Project.create!(:key => "FOO", :name => "Foo")
        end

        before :each do
          put :update, :id => existing.id, :project => { :key => "BAR" }, :use_route => :tyne_core
        end

        it "should update the record" do
          TyneCore::Project.find_by_id(existing.id).key.should == "BAR"
        end

        it "should render the correct view" do
          response.should render_template "projects/_project"
        end
      end

      context :failure do
        xit "should return the error message" do
          put :update, :use_route => :tyne_core

          response.should_not be_success
        end
      end
    end

    describe :destroy do
      let(:project) do
        TyneCore::Project.create!(:key => "FOO", :name => "Foo")
      end

      before :each do
        delete :destroy, :id => project.id, :format => :json
      end

      it "should destroy the record" do
        TyneCore::Project.find_by_id(project.id).should_not be_present
      end

      it "should respond with ok" do
        response.should be_success
      end
    end

    describe :github do
      before :each do
        user.stub_chain(:github_client, :repositories).and_return(:foo)
        get :github, :use_route => :tyne_core
      end

      it "should assign a list of all github repos" do
        assigns(:repositories).should == :foo
      end

      it "should render the correct view" do
        response.should render_template "projects/github"
      end
    end

    describe :import do
      before :each do
        post :import, :name => ["Foo", "Bar"], :use_route => :tyne_core
      end

      it "should create a project for each selected github repo" do
        TyneCore::Project.find_by_name("Foo").should be_present
        TyneCore::Project.find_by_name("Bar").should be_present
      end

      it "should redirect back to the index page" do
        response.should redirect_to :action => :index
      end
    end
  end
end
