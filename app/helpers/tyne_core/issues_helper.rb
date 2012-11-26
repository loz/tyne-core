module TyneCore
  # Provides issue related helper methods
  module IssuesHelper
    # Displays a label with the issue reporter
    def issue_reported_by(issue)
      issue_label("Reporter", issue.reported_by.name)
    end

    # Displays a label with the issue type
    def issue_type(issue, short = false)
      name = if short
              issue.issue_type.name[0].upcase
             else
              issue.issue_type.name
             end
      classes = [issue.issue_type.name.underscore]
      classes << "tag-short" if short
      issue_label("Type", name, classes) if issue.issue_type
    end

    # Displays a label with the issue priority
    def issue_priority(issue, short = false)
      return unless issue.issue_priority

      name = if short
              issue.issue_priority.name[0].upcase
             else
              issue.issue_priority.name
             end
      classes = [issue.issue_priority.name.underscore]
      classes << "tag-short" if short
      issue_label("Priority", name, classes) if issue.issue_priority
    end

    # Displays a label with the date when the issue has been reported
    def issue_reported_at(issue)
      date = issue.created_at.to_date
      content = if date.today?
                  "Today"
                else
                  date
                end
      issue_label("Opened", content)
    end

    # Displays a label for the current state
    def issue_state(issue)
      content = I18n.t("states.#{issue.state}")
      issue_label("State", content, [issue.state.to_s.underscore])
    end


    # Displays a formatted string in the following format:
    # {ProjectKey}-{IssueId} e.g. TYNE-1337
    def issue_id(issue)
      klasses = ["issue-key"]
      klasses << "issue-closed" if issue.closed?
      link_to issue.key, main_app.issue_path(:user => issue.project.user.username, :key => issue.project.key, :id => issue.number), :class => klasses.join(" ")
    end

    # Returns the default workflow action as a link
    def default_action(issue)
      transition = case issue.state
                   when "open", "reopened"
                     :start_working
                   when "wip"
                     :task_is_done
                   when "invalid", "done"
                     :reopen
                   end
      label = I18n.t("states.transitions.#{transition}")
      url = main_app.workflow_issue_path(:user => issue.project.user.username, :key => issue.project.key, :id => issue.number, :transition => transition)
      link_to(label, url, :class => "btn btn-small")
    end

    # Renders a tag with the amount of comments as text.
    def issue_comments(issue)
      klasses = ["tag-short"]
      klasses << "comments-present" if issue.comments.count > 0
      issue_label("Comments", issue.comments.count, klasses)
    end

    private
    def issue_label(name, value, classes=[])
      classes << "tag" unless classes.include? "tag"
      title = "#{name}: #{value}"

      content_tag :span, value, :class => classes.join(' '), :title => title
    end
  end
end
