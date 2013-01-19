module TyneCore
  # Formats comment audits
  class CommentAuditFormatter < AuditFormatter::Base
    # Converts a comment audit into a user readable message
    def format
      "#{user_link} commented on #{issue_link}".html_safe
    end

    def icon
      image_tag "icon-sweets/32/comments.png"
    end

    # Returns the comment message.
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
      link_to issue.summary, issue_path(:user => project.user.username, :key => project.key, :id => issue.number)
    end
  end
end
