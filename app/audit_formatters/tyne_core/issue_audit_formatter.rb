module TyneCore
  # Formats an issue audit
  class IssueAuditFormatter < AuditFormatter::Base
    include TyneCore::AvatarHelper

    # Formats an issue audit into a human readable format.
    def format
      try(object.action)
    end

    def icon
      image_tag "icon-sweets/32/#{icon_name}"
    end

    def details
      return issue.description if create?
    end

    # Returns a formatted message for a new issue
    def create
      "#{user_link} has reported #{issue_link} for project #{project_link}".html_safe
    end

    # Returns a formatted message for an updated issue
    def update
      "#{user_link} has updated issue #{issue_link} for project #{project_link}".html_safe
    end

    private
    def issue
      @issue ||= object.auditable
    end

    def project
      @project ||= issue.project
    end

    def issue_link
      link_to issue.summary, issue_path(:user => project.user.username, :key => project.key, :id => issue.number)
    end

    def project_link
      link_to project.name, backlog_path(:user => project.user.username, :key => project.key)
    end

    def icon_name
      return "issue-created.png" if create?
      return "issue-updated.png" if update?
    end
  end
end
