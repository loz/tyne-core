module TyneCore
  # Provides view helpers for the sprints in the core engine.
  module SprintsHelper
    def percent_done(issues)
      total = issues.count
      relative = issues.closed.count

      percent_relative(total, relative)
    end

    def percent_wip(issues)
      total = issues.count
      relative = issues.in_progress.count

      percent_relative(total, relative)
    end

    def percent_todo(issues)
      total = issues.count
      relative = issues.to_do.count

      percent_relative(total, relative)
    end

    private
    def percent_relative(total, relative)
      ((relative.to_f / total.to_f) * 100)
    end
  end
end
