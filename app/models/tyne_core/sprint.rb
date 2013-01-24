module TyneCore
  class Sprint < ActiveRecord::Base
    attr_accessible :end_date, :name, :project_id, :start_date

    has_many :issues, :class_name => 'TyneCore::SprintItem', :order => 'sprint_position'

    validates :name, :project_id, :presence => true
  end
end
