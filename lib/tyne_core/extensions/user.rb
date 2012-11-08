module TyneCore
  module Extensions
    # Extends the user object from TyneAuth
    module User
      extend ActiveSupport::Concern

      included do
        has_many :projects, :class_name => "TyneCore::Project"
      end
    end
  end
end
