module TyneCore
  # Represents a project.
  class Project < ActiveRecord::Base
    attr_accessible :description, :key, :name

    validates :key, :name, :user_id, :presence => true
    validates :key, :name, :uniqueness => { :scope => :user_id }
    validates :key, :format => { :with => /^[a-zA-Z\d\s]*$/ }

    belongs_to :user, :class_name => "TyneAuth::User"
    has_many :issues, :class_name => "TyneCore::Issue"
  end
end
