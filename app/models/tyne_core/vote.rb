module TyneCore
  # Represents a vote (up/down) for an arbitrary resource
  class Vote < ActiveRecord::Base
    belongs_to :user, :class_name => '::TyneAuth::User'
    belongs_to :votable, :polymorphic => true

    attr_accessible :user, :weight
  end
end
