module TyneCore
  class IssueAuditFormatter < AuditFormatter::Base
    include TyneCore::AvatarHelper

    def format
      try(object.action)
    end

    def create
      "#{avatar_link} #{user_link} has reported #{issue_link} for project #{project_link}".html_safe
    end

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
