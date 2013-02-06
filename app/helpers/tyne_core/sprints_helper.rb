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

    def start_sprint_button(sprint)
      options = { :class => "btn btn-small", :data => { :toggle => 'modal' } }

      title = ""
      if @project.any_running?
        options[:disabled] = :disabled
        title = t("sprints.already_running")
      end

      if sprint.issues.empty?
        options[:disabled] = :disabled
        title = t("sprints.zero_issues")
      end

      options[:title] = title unless title.empty?

      link_to "Start", "#sprint_#{sprint.id}_dialog", options
    end

    private
    def percent_relative(total, relative)
      ((relative.to_f / total.to_f) * 100)
    end
  end
end
