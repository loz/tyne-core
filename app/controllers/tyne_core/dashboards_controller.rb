require_dependency "tyne_core/application_controller"

module TyneCore
  # Handles all requests for dashboards
  class DashboardsController < ApplicationController
    self.responder = ::ApplicationResponder
    respond_to :html, :json

    before_filter :require_login

    # Displays the index view with the default dashboard
    def index
      @projects = current_user.projects
      @new_projects = TyneCore::Project.order("created_at DESC")

      load_activities
    end

    private

    def load_activities(from_date = DateTime.now.weeks_ago(1), to_date = DateTime.now)
      pt = TyneCore::Project.arel_table
      @created_projects = current_user.projects.where(pt[:created_at].gteq(from_date).and(pt[:created_at].lteq(to_date))).order(pt[:created_at].desc).all
      @updated_projects = current_user.projects.where(pt[:created_at].not_eq(pt[:updated_at]).and(pt[:updated_at].not_eq(nil)).and(pt[:updated_at].gteq(from_date).and(pt[:updated_at].lteq(to_date)))).order(pt[:updated_at].desc).all

      it = TyneCore::Issue.arel_table
      project_ids = current_user.projects.all.map(&:id)
      @created_issues = TyneCore::Issue.where(it[:project_id].in(project_ids).and(it[:created_at].gteq(from_date).and(it[:created_at].lteq(to_date)))).order(it[:created_at].desc).all
      @updated_issues = TyneCore::Issue.where(it[:project_id].in(project_ids).and(it[:created_at].not_eq(it[:updated_at]).and(it[:updated_at].not_eq(nil).and(it[:updated_at].gteq(from_date).and(it[:updated_at].lteq(to_date)))))).order(it[:updated_at].desc).all

      ct = TyneCore::Comment.arel_table
      issue_ids = TyneCore::Issue.where(it[:project_id].in(project_ids)).all.map(&:id)
      @created_comments = TyneCore::Comment.where(ct[:issue_id].in(issue_ids).and(ct[:created_at].gteq(from_date).and(ct[:created_at].lteq(to_date)))).order(ct[:created_at].desc).all
    end
  end
end
