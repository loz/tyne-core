require_dependency "tyne_core/application_controller"

module TyneCore
  # Handles requests for issue creation, updates, deletions
  class IssuesController < ApplicationController
    self.responder = ::ApplicationResponder
    respond_to :html, :json

    before_filter :load_project

    # Displays the index view with the default dashboard
    def index
      @issues = current_user.reported_issues
    end

    private
    def load_project
      @project = TyneCore::Project.find(params[:project_id])
    end
  end
end
