module TyneCore
  # A Sprint is an iteration to deliver a subset of your product backlog
  # in a certain time frame.
  class Sprint < ActiveRecord::Base
    attr_accessible :end_date, :name, :project_id, :start_date

    has_many :issues, :class_name => 'TyneCore::SprintItem', :order => 'sprint_position'

    validates :name, :project_id, :presence => true

    # Starts the sprint. Only valid if there is no running sprint.
    def start
      save
    end
  end
end
