module TyneCore
  class TeamMembersController < ApplicationController
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

      @team_member.destroy

      respond_with(@team_member, :location => main_app.team_path(:user => current_user.username, :key => @project.key, :id => @team.id))
    end
  end
end
