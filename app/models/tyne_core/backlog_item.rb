module TyneCore
  class BacklogItem < Issue
    acts_as_list :scope => :project, :column => "position"
  end
end
