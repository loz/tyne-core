module TyneCore
  class Team < ActiveRecord::Base
    belongs_to :project
    has_many :members, :class_name => "TyneCore::TeamMember", :autosave => true

    validates :project, :presence => true
    attr_accessible :name
  end
end
