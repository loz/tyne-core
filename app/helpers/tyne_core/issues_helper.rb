module TyneCore
  # Provides issue related helper methods
  module IssuesHelper
    # Displays a label with the issue reporter
    def issue_reported_by(issue)
      issue_label("Reporter", issue.reported_by.name)
    end

    # Displays a label with the issue type
    def issue_type(issue)
      issue_label("Type", issue.issue_type.name, [issue.issue_type.name.underscore]) if issue.issue_type
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

    # Displays a formatted string in the following format:
    # {ProjectKey}-{IssueId} e.g. TYNE-1337
    def issue_id(issue)
      "#{issue.project.key}-#{issue.id}"
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
      url = main_app.workflow_issue_path(:user => issue.project.user.username, :key => issue.project.key, :id => issue.id, :transition => transition)
      link_to(label, url, :class => "btn btn-small")
    end

    private
    def issue_label(name, value, classes=[])
      classes << "tag" unless classes.include? "tag"
      content = "#{name}: #{value}"
      content_tag :span, content, :class => classes.join(' ')
    end
  end
end
