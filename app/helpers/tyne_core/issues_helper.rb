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
      "#{issue.project.key}-#{issue.number}"
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

    private
    def issue_label(name, value, classes=[])
      classes << "tag" unless classes.include? "tag"
      title = "#{name}: #{value}"

      content_tag :span, value, :class => classes.join(' '), :title => title
    end
  end
end
