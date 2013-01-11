module TyneCore
  class TeamsController < AdminController
    self.responder = ::ApplicationResponder
    respond_to :html, :json

    before_filter :load_project

    def show
      @team = @project.teams.find_by_id(params[:id])
      respond_with(@team)
    end
  end
end
