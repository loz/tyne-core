require_dependency "tyne_core/application_controller"

module TyneCore
  # Handles requests for issue creation, updates, deletions
  class IssuesController < TyneCore::ApplicationController
    self.responder = ::ApplicationResponder
    respond_to :html, :json

    before_filter :load_user
    before_filter :load_project
    before_filter :load_issue, :only => [:workflow, :edit, :update, :show, :upvote, :downvote]

    # Displays the index view with the backlog.
    # The backlog can be sorted by passing a sorting parameter.
    def index
      reflection = @project.issues
      reflection = apply_filter(reflection)
      reflection = apply_sorting(reflection)
      reflection = apply_pagination(reflection)

      @issues = reflection
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
      @issue = @project.issues.build
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

    # Votes the issue up
    def upvote
      @issue.upvote_for(current_user) if @issue.votes.where(:user_id => current_user.id).sum(:weight) < 1
      render :json => @issue.total_votes.to_json
    end

    # Votes the issue down
    def downvote
      @issue.downvote_for(current_user) if @issue.votes.where(:user_id => current_user.id).sum(:weight) > -1
      render :json => @issue.total_votes.to_json
    end

    private
    def show_path
      main_app.issue_path(:user => @project.user.username, :key => @project.key, :id => @issue.number)
    end
  end
end
