module TyneCore
  class IssuePriority < ActiveRecord::Base
    attr_accessible :name, :number

    default_scope order("number ASC")
  end
end
