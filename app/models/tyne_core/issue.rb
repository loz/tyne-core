module TyneCore
  # Represents an issue that affects a particular project.
  # Issues can be part of a sprint and they have an issue type.
  class Issue < ActiveRecord::Base
    belongs_to :reported_by, :class_name => "TyneAuth::User"
    belongs_to :project, :class_name => "TyneCore::Project"

    attr_accessible :summary, :description, :reported_by_id
  end
end
