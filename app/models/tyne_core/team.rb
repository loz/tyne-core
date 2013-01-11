module TyneCore
  # Represents a team for a project.
  # A team can allow a member to have admin privileges.
  class Team < ActiveRecord::Base
    belongs_to :project
    has_many :members, :class_name => "TyneCore::TeamMember", :autosave => true

    validates :project, :presence => true
    attr_accessible :name
  end
end
