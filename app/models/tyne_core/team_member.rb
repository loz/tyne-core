module TyneCore
  class TeamMember < ActiveRecord::Base
    belongs_to :user, :class_name => "TyneAuth::User"
    belongs_to :team, :class_name => "TyneCore::Team"

    validates :user, :team, :presence => true
    validates :user_id, :uniqueness => { :scope => :team_id }

    attr_accessible :user_id
  end
end