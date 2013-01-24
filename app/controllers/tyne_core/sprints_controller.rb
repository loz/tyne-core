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

    def index
      @sprints = @project.sprints
      @issues = @project.backlog_items.not_completed.where(:sprint_id => nil)
    end

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

    def destroy
      @sprint = @project.sprints.find(params[:id])
      if @sprint.destroy
        render :json => :ok
      else
        render :json => { :errors => @sprint.errors }, :status => :entity_unprocessable
      end
    end

    def reorder
      @issue = @project.sprint_items.find(params[:issue_id])
      @issue.project.backlog_items.find(params[:issue_id]).remove_from_list

      @issue.sprint_id = @project.sprints.find(params[:id]).id
      @issue.save

      if @issue.insert_at(params[:position].to_i)
        render :json => :ok
      else
        render :json => { :errors => @issue.errors }, :status => :entity_unprocessable
      end
    end

    private
    def prepare_breadcrumb
      add_breadcrumb "Planning"
    end
  end
end
