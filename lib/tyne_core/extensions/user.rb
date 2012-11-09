module TyneCore
  module Extensions
    # Extends the user object from TyneAuth
    module User
      extend ActiveSupport::Concern

      included do
        has_many :projects, :class_name => "TyneCore::Project"
        has_many :dashboards, :class_name => "TyneCore::Dashboard"

        after_initialize :set_defaults
      end

      # Returns the first dashboard in the list.
      # This method is supposed to return the dashboard that's marked as default in the nearer future.
      #
      # @return [TyneCore::Dashboard] default dashboard
      def default_dashboard
        dashboards.first
      end

      def set_defaults
        self.dashboards.build(:name => "Default")
      end
      private :set_defaults
    end
  end
end
