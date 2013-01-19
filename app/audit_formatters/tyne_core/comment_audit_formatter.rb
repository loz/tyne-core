module TyneCore
  class CommentAuditFormatter < AuditFormatter::Base
    def format
      "#{avatar_link} #{user_link} commented on #{issue_link}".html_safe
    end

    def details
      comment.message
    end

    private
    def comment
      @comment ||= object.auditable
    end

    def issue
      @issue ||= comment.issue
    end

    def project
      @project ||= issue.project
    end

    def issue_link
      link_to issue.summary, issue_path(:user => user.username, :key => project.key, :id => issue.number)
    end
  end
end
