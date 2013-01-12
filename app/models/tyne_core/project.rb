module TyneCore
  # Represents a project.
  class Project < ActiveRecord::Base
    attr_accessible :description, :key, :name

    validates :key, :name, :user_id, :presence => true
    validates :key, :name, :uniqueness => { :scope => :user_id }
    validates :key, :format => { :with => /^[a-zA-Z\d\s]*$/ }

    belongs_to :user, :class_name => "TyneAuth::User"
    has_many :issues, :class_name => "TyneCore::Issue"
    has_many :teams, :class_name => "TyneCore::Team", :autosave => true
    has_many :owners, :class_name => "TyneCore::TeamMember", :through => :teams, :conditions => { :tyne_core_teams => { :admin_privileges => true } }, :source => :members

    before_create :create_teams

    private
    def create_teams
      owners = self.teams.build(:name => "Owners") do |team|
        team.admin_privileges = true
      end
      owners.members.build(:user_id => self.user_id)
      self.teams.build(:name => "Contributors")
    end
  end
end
