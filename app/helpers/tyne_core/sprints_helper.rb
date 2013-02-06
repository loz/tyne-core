module TyneCore
  # Provides view helpers for the sprints in the core engine.
  module SprintsHelper
    # Calculate the percent of done issues.
    def percent_done(issues)
      total = issues.count
      relative = issues.closed.count

      percent_relative(total, relative)
    end

    # Calculate the percent of issues which are in progress.
    def percent_wip(issues)
      total = issues.count
      relative = issues.in_progress.count

      percent_relative(total, relative)
    end

    # Calculate the percent of issues which still need to be done.
    def percent_todo(issues)
      total = issues.count
      relative = issues.to_do.count

      percent_relative(total, relative)
    end

    # Renders a start sprint for a particular sprint.
    # The button will be disabled if either a sprint is already running
    # or if the sprint is empty (no issues).
    def start_sprint_button(sprint)
      options = { :class => "btn btn-small start-sprint", :data => { :toggle => 'modal', :target => "#sprint_#{sprint.id}_dialog" } }

      title = ""

      if sprint.issues.empty?
        options[:disabled] = :disabled
        title = t("sprints.zero_issues")
      end

      if @project.any_running?
        options[:disabled] = :disabled
        options[:data][:running] = true
        title = t("sprints.already_running")
      end

      options[:title] = title unless title.empty?

      button_tag "Start", options
    end

    private
    def percent_relative(total, relative)
      ((relative.to_f / total.to_f) * 100)
    end
  end
end
