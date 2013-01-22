module TyneCore
  class Sprint < ActiveRecord::Base
    attr_accessible :end_date, :name, :project_id, :start_date

    validates :name, :project_id, :presence => true
  end
end
