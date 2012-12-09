module TyneCore
  # Provides helper methods for the dashboard
  module DashboardsHelper
    # Generates a chronological set of activities from the given records.
    # The resulting 2-dimensional array has the format:
    #
    #   activities[i][0] -> [DateTime]
    #   activities[i][1] -> [String]
    #
    # @return [Array]
    def merge_activities(created_projects, updated_projects, created_issues, updated_issues, created_comments)
      activities = []

      created_projects.each do |p|
        activities << [
          format_date(p.created_at),
          "#{user_link(p.user)} created project #{project_link(p)}"
        ]
      end

      updated_projects.each do |p|
        activities << [
          format_date(p.updated_at),
          "Project #{project_link(p)} has been updated"
        ]
      end

      created_issues.each do |i|
        activities << [
          format_date(i.created_at),
          "#{user_link(i.reported_by)} reported #{issue_link(i)} (#{project_link(i.project)})"
        ]
      end

      updated_issues.each do |i|
        activities << [
          format_date(i.updated_at),
          "Issue #{issue_link(i)} (#{project_link(i.project)}) has been updated"
        ]
      end

      created_comments.each do |c|
        activities << [
          format_date(c.created_at),
          "#{user_link(c.user)} commented on #{issue_link(c.issue)} (#{project_link(c.issue.project)})<div class=\"comment-message\">#{markup_to_html(c.message)}</div>"
        ]
      end

      activities.sort_by {|a| a[0]}.reverse
    end

    # Generates the link to a user's overview page
    #
    # @param [TyneAuth::User] user
    # @return [String]
    def user_link(user)
      link_to user.username, main_app.overview_path(:user => user.username)
    end

    # Generates the link to a projects backlog page
    #
    # @param [TyneCore::Project] project
    # @return [String]
    def project_link(project)
      link_to project.name, main_app.backlog_path(:user => project.user.username, :key => project.key)
    end

    # Generates the link to an issue's show page
    #
    # @param [TyneCore::Issue] issue
    # @return [String]
    def issue_link(issue)
      link_to issue.summary, main_app.issue_path(:user => issue.project.user.username, :key => issue.project.key, :id => issue.number)
    end

    # Returns the formatted date
    #
    # @param [DateTime] date
    # @return [String]
    def format_date(date)
      I18n.localize(date, :format => :long)
    end
  end
end
