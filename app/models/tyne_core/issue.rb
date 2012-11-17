module TyneCore
  # Represents an issue that affects a particular project.
  # Issues can be part of a sprint and they have an issue type.
  class Issue < ActiveRecord::Base
    belongs_to :reported_by, :class_name => "TyneAuth::User"
    belongs_to :project, :class_name => "TyneCore::Project"

    attr_accessible :project_id, :summary, :description

    validates :project_id, :summary, :presence => true

    default_scope includes(:project).includes(:reported_by)
  end
end
