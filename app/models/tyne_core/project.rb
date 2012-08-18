module TyneCore
  class Project < ActiveRecord::Base
    attr_accessible :description, :key, :name
  end
end
