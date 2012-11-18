require_dependency "tyne_core/application_controller"

module TyneCore
  # Handles requests for issue creation, updates, deletions
  class IssuesController < ApplicationController
    self.responder = ::ApplicationResponder
    respond_to :html, :json

    before_filter :load_project

    # Displays the index view with the default dashboard
    def index
      @issues = @project.issues
    end

    # Creates a new issue
    def create
      @issue = @project.issues.build(params[:issue])
      @issue.reported_by = current_user
      @issue.save

      respond_with(@issue, :location => main_app.issue_path(:user => @project.user.username, :key => @project.key, :id => @issue.id))
    end

    # Displays the new page for issue creation
    def new
      @issue = TyneCore::Issue.new
    end

    # Displays the edit page for an issue.
    def edit
      @issue = TyneCore::Issue.find(params[:id])
      respond_with(@issue)
    end

    # Updates a given issue
    def update
      @issue = TyneCore::Issue.find(params[:id])
      @issue.update_attributes(params[:issue])
      respond_with(@issue, :location => main_app.issue_path(:user => @project.user.username, :key => @project.key, :id => @issue.id))
    end

    # Displays an existing Issue
    def show
      @issue = TyneCore::Issue.find(params[:id])
      respond_with(@issue)
    end

    # Renders a dialog partial
    def dialog
      @issue = TyneCore::Issue.new

      render 'dialog'
    end

    private
    def load_project
      @project = TyneCore::Project.joins(:user).where(:key => params[:key]).where(:tyne_auth_users => {:username => params[:user]  }).first
    end
  end
end
