# Application controller for core engine.
class TyneCore::ApplicationController < ApplicationController
  private
  def load_user
    @user = TyneAuth::User.find_by_username(params[:user])
  end

  def load_project
    @project = TyneCore::Project.joins(:user).where(:key => params[:key]).where(:tyne_auth_users => {:username => params[:user]  }).first
  end

  def load_issue
    @issue = @project.issues.find_by_number(params[:id])
  end
end
