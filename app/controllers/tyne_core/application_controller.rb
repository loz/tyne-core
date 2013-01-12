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

  def is_admin_area?
    false
  end
  helper_method :is_admin_area?

  def require_owner
    redirect_to main_app.root_path unless is_owner?
  end

  def is_owner?
    @project.owners.map { |x| x.user }.include? current_user
  end
  helper_method :is_owner?
end
