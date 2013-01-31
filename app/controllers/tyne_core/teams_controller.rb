module TyneCore
  # Handles request to show the team structure of a project
  class TeamsController < AdminController
    self.responder = ::ApplicationResponder
    respond_to :html, :json

    before_filter :require_login
    before_filter :load_user
    before_filter :load_project
    before_filter :load_team
    before_filter :prepare_breadcrumb
    before_filter :require_owner

    # Displays the list of all teams inside a project.
    def show
      respond_with(@team)
    end

    def suggest_user
      scope = TyneAuth::User.scoped
      scope = scope.where("username LIKE ?", "%#{params[:term]}%")
      @team.members.all.each do |member|
        scope = scope.where(TyneAuth::User.arel_table[:id].not_eq(member.user.id))
      end
      respond_with(scope.all.map{|x| {:label => x.username, :value => x.id}})
    end

    private

    def load_team
      @team = @project.teams.find_by_id(params[:id])
    end

    def prepare_breadcrumb
      add_breadcrumb "Admin", main_app.admin_project_path(:user => params[:user], :key => params[:key], :anchor => "teams")
      add_breadcrumb @team.name, main_app.admin_project_path(:user => params[:user], :key => params[:key])
    end
  end
end
