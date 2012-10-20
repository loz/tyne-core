module TyneCore
  class Project < ActiveRecord::Base
    attr_accessible :description, :key, :name

    validates :key, :presence => true
    validates :name, :presence => true
  end
end
