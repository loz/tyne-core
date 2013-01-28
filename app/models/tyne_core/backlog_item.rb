module TyneCore
  # A BacklogItem is an Issue that is not part of any sprint.
  class BacklogItem < Issue
    attr_accessible :project_id, :summary, :description, :issue_type_id, :issue_priority_id, :assigned_to_id

    acts_as_list :scope => :project, :column => "position"
  end
end
