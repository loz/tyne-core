module TyneCore
  # Represents a project.
  class Project < ActiveRecord::Base
    attr_accessible :description, :key, :name

    validates :key, :name, :presence => true
  end
end
