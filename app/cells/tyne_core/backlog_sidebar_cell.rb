module TyneCore
  # Cell for backlog sidebar
  class BacklogSidebarCell < Cell::Rails
    # Displays a filter pod
    def filter
      render
    end

    # Displays a sorting pod
    def sorting
      render
    end

    # Displays a grouping pod
    def grouping
      render
    end
  end
end
