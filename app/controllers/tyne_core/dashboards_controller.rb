require_dependency "tyne_core/application_controller"

module TyneCore
  # Handles all requests for dashboards
  class DashboardsController < ApplicationController
    self.responder = ::ApplicationResponder
    respond_to :html, :json

    # Displays the index view with the default dashboard
    def index
      @projects = current_user.projects
      @new_projects = TyneCore::Project.order("created_at DESC")
    end
  end
end
