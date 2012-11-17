module TyneCore
  # Provides issue related helper methods
  module IssuesHelper
    # Displays a label with the issue reporter
    def issue_reported_by(issue)
      issue_label("Reporter", issue.reported_by.name)
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

    private
    def issue_label(name, value, classes=[])
      classes << "tag" unless classes.include? "tag"
      content = "#{name}: #{value}"
      content_tag :span, content, :class => classes.join(' ')
    end
  end
end
