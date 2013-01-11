module TyneCore
  # Handles request to show the team structure of a project
  class TeamsController < AdminController
    self.responder = ::ApplicationResponder
    respond_to :html, :json

    before_filter :load_project

    # Displays the list of all teams inside a project.
    def show
      @team = @project.teams.find_by_id(params[:id])
      respond_with(@team)
    end
  end
end
