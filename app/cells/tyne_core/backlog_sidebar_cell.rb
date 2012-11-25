module TyneCore
  # Cell for backlog sidebar
  class BacklogSidebarCell < Cell::Rails
    # Displays a pod with predefined search options
    def search
      render
    end

    # Displays a filter pod
    def filter
      @fields = [
        [:issue_type_id, TyneCore::IssueType.all.map { |x| [x.name, x.id] } ],
        [:state, TyneCore::Issue.state_machine.states.map { |x| [I18n.t("states.#{x.name}"),  x.name] } ]
      ]
      render
    end

    # Displays a sorting pod
    def sorting
      fields = [:created_at, :updated_at, :issue_type, :state]
      order = [:asc, :desc]

      @fields = fields.map { |x| [TyneCore::Issue.human_attribute_name(x), x] }
      @orders = order.map { |x| [I18n.t("order.#{x}"), x] }
      @field = session[:sorting] ? session[:sorting][:field] : :created_at
      @order = session[:sorting] ? session[:sorting][:order] : :asc

      render
    end

    # Displays a grouping pod
    def grouping
      render
    end
  end
end
