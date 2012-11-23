module TyneCore
  class Comment < ActiveRecord::Base
    belongs_to :user, :class_name => "TyneAuth::User"
    belongs_to :issue, :class_name => "TyneCore::Issue"

    validates :message, :issue_id, :user_id, :presence => true

    attr_accessible :message
  end
end
