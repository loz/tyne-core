require "tyne_core/extensions/issues/workflow"

module TyneCore
  # Represents an issue that affects a particular project.
  # Issues can be part of a sprint and they have an issue type.
  class Issue < ActiveRecord::Base
    include TyneCore::Extensions::Issues::Workflow

    belongs_to :reported_by, :class_name => "TyneAuth::User"
    belongs_to :project, :class_name => "TyneCore::Project"
    belongs_to :issue_type, :class_name => "TyneCore::IssueType"

    attr_accessible :project_id, :summary, :description, :issue_type_id

    validates :project_id, :summary, :issue_type_id, :presence => true

    default_scope includes(:project).includes(:reported_by).includes(:issue_type)
  end
end
