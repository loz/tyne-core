module TyneCore
  # Handles request for sprints of a project
  class SprintsController < AdminController
    self.responder = ::ApplicationResponder
    respond_to :html, :json, :pjax

    before_filter :require_login
    before_filter :load_user
    before_filter :load_project
    before_filter :prepare_breadcrumb
    before_filter :ensure_can_collaborate

    helper :"tyne_core/issues"

    # Displays the planning page.
    def index
      @sprints = @project.sprints
      @issues = @project.backlog_items.not_completed.where(:sprint_id => nil)
    end

    # Creates a new sprint.
    def create
      @sprint = @project.sprints.create(:name => "Unnamed sprint")

      render @sprint
    end

    # Upates a sprint
    def update
      @sprint = @project.sprints.find(params[:id])
      @sprint.update_attributes(params[:sprint])
      respond_with(@sprint)
    end

    # Destroys a sprint
    def destroy
      @sprint = @project.sprints.find(params[:id])
      if @sprint.destroy
        render :json => :ok
      else
        render :json => { :errors => @sprint.errors }, :status => :entity_unprocessable
      end
    end

    # Changes the ranking inside a particular sprint. If the item is not already
    # in the sprint it will be added.
    # The item will get removed from the backlog if it used to be there.
    def reorder
      @issue = @project.sprint_items.find(params[:issue_id])
      @issue.becomes(TyneCore::BacklogItem).remove_from_list

      @issue.remove_from_list

      @issue.sprint_id = @project.sprints.find(params[:id]).id
      @issue.save

      if @issue.insert_at(params[:position].to_i)
        render :json => :ok
      else
        render :json => { :errors => @issue.errors }, :status => :entity_unprocessable
      end
    end

    # Starts a new sprint.
    def start
      @sprint = @project.sprints.find(params[:id])
      @sprint.start

      respond_with(@sprint, :location => main_app.sprints_path(:user => @project.user.username, :key => @project.key))
    end

    private
    def prepare_breadcrumb
      add_breadcrumb "Planning"
    end
  end
end
