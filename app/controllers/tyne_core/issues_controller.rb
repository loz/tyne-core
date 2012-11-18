require_dependency "tyne_core/application_controller"

module TyneCore
  # Handles requests for issue creation, updates, deletions
  class IssuesController < ApplicationController
    self.responder = ::ApplicationResponder
    respond_to :html, :json

    before_filter :load_project
    before_filter :load_issue, :only => [:workflow, :edit, :update, :show]

    # Displays the index view with the default dashboard
    def index
      @issues = @project.issues.not_completed
    end

    # Creates a new issue
    def create
      @issue = @project.issues.build(params[:issue])
      @issue.reported_by = current_user
      @issue.save

      respond_with(@issue, :location => show_path)
    end

    # Displays the new page for issue creation
    def new
      @issue = TyneCore::Issue.new
    end

    # Performs a workflow transition
    def workflow
      @issue.send(params[:transition]) if @issue.state_transitions.any? { |x| x.event == params[:transition].to_sym }
      redirect_to show_path
    end

    # Displays the edit page for an issue.
    def edit
      respond_with(@issue)
    end

    # Updates a given issue
    def update
      @issue.update_attributes(params[:issue])
      respond_with(@issue, :location => show_path)
    end

    # Displays an existing Issue
    def show
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

    def load_issue
      @issue = @project.issues.find_by_number(params[:id])
    end

    def show_path
      main_app.issue_path(:user => @project.user.username, :key => @project.key, :id => @issue.number)
    end
  end
end
