module TyneCore
  # Cell for backlog sidebar
  class BacklogSidebarCell < Cell::Rails
    # Displays a filter pod
    def filter
      render
    end

    # Displays a sorting pod
    def sorting
      fields = [:created_at, :updated_at, :issue_type, :state]
      order = [:asc, :desc]

      @fields = fields.map { |x| [TyneCore::Issue.human_attribute_name(x), x] }
      @order = order.map { |x| [I18n.t("order.#{x}"), x] }

      render
    end

    # Displays a grouping pod
    def grouping
      render
    end
  end
end
