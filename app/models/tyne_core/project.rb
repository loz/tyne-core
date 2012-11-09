module TyneCore
  # Represents a project.
  class Project < ActiveRecord::Base
    attr_accessible :description, :key, :name

    validates :key, :name, :user_id, :presence => true
    validates :key, :name, :uniqueness => { :scope => :user_id }
  end
end
