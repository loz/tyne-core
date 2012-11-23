require "tyne_core/extensions/issues/workflow"

module TyneCore
  # Represents an issue that affects a particular project.
  # Issues can be part of a sprint and they have an issue type.
  class Issue < ActiveRecord::Base
    include TyneCore::Extensions::Issues::Workflow

    belongs_to :reported_by, :class_name => "TyneAuth::User"
    belongs_to :project, :class_name => "TyneCore::Project"
    belongs_to :issue_type, :class_name => "TyneCore::IssueType"

    has_many :comments, :class_name => "TyneCore::Comment"

    attr_accessible :project_id, :summary, :description, :issue_type_id

    validates :project_id, :summary, :issue_type_id, :number, :presence => true
    validates :number, :uniqueness => { :scope => :project_id }

    default_scope includes(:project).includes(:reported_by).includes(:issue_type).includes(:comments)

    after_initialize :set_defaults
    before_validation :set_number, :on => :create

    scope :sort_by_issue_type, lambda { |sord| joins(:issue_type).order("tyne_core_issue_types.name #{sord}") }

    def set_defaults
      self.issue_type_id ||= TyneCore::IssueType.first.id
    end
    private :set_defaults

    def set_number
      self.number = (project.issues.maximum('number') || 0) + 1
    end
    private :set_number
  end
end
