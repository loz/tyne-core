module TyneCore
  class SprintItem < Issue
    acts_as_list :scope => :sprint, :column => "sprint_position"
  end
end
