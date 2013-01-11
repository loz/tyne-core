module TyneCore
  class TeamMembersController < AdminController
    self.responder = ::ApplicationResponder
    respond_to :html, :json

    before_filter :load_project

    def create
      @team = @project.teams.find_by_id(params[:team_id])
      @team_member = @team.members.build(params[:team_member])
      @team_member.save

      respond_with(@team_member, :location => main_app.team_path(:user => current_user.username, :key => @project.key, :id => @team.id))
    end

    def destroy
      @team = @project.teams.find_by_id(params[:team_id])
      @team_member = @team.members.find_by_id(params[:id])

      if check_if_is_loosing_admin_rights(@team_member)
        @team_member.errors.add(:base, "Do not do this fool!")
      else
        @team_member.destroy
      end


      respond_with(@team_member, :location => main_app.team_path(:user => current_user.username, :key => @project.key, :id => @team.id), :flash_now => false)
    end

    private
    def check_if_is_loosing_admin_rights(team_member)
      team_member.user == current_user && team_member.is_admin?
    end
  end
end
