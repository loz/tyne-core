module TyneCore
  # Formats an issue audit
  class IssueAuditFormatter < AuditFormatter::Base
    include TyneCore::AvatarHelper

    # Formats an issue audit into a human readable format.
    def format
      try(object.action)
    end

    # Returns a formatted message for a new issue
    def create
      "#{avatar_link} #{user_link} has reported #{issue_link} for project #{project_link}".html_safe
    end

    # Returns a formatted message for an updated issue
    def update
      "#{avatar_link} #{user_link} has updated issue #{issue_link} for project #{project_link}".html_safe
    end

    private
    def issue
      @issue ||= object.auditable
    end

    def project
      @project ||= issue.project
    end

    def issue_link
      link_to issue.summary, issue_path(:user => user.username, :key => project.key, :id => issue.number)
    end

    def project_link
      link_to project.name, backlog_path(:user => user.username, :key => project.key)
    end
  end
end
