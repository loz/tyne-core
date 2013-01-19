module TyneCore
  # Contains logic to format audit messages
  module AuditFormatter
    # Base class for formatted audit messages
    class Base
      include Rails.application.routes.url_helpers
      include ActionView::Helpers::UrlHelper
      include ActionView::Helpers::AssetTagHelper
      include TyneCore::AvatarHelper

      @@default_url_options = {:host => 'www.example.com'}

      attr_reader :object, :options

      def initialize(object, options={})
        @object, @options = object, options
      end

      # Abstract format method. Needs to be overriden in the sub class.
      def format
        raise NotImplementedError
      end

      # Returns details for an audit.
      def details
        nil
      end

      private
      def user
        @user ||= object.user
      end

      def user_link
        link_to user.username, overview_path(:user => user.username)
      end

      def avatar_link
        link_to avatar(user, :url => root_path, :width => 48), overview_path(:user => user.username)
      end

      def url_options
        @@default_url_options
      end

      def controller
        @controller ||= ActionController::Base.new
      end

      def config
        @config ||= Rails.application.config
      end
    end

    # Extends the audit class to have a formatted method.
    module Support
      extend ActiveSupport::Concern

      # Returns the particular formatter constant.
      #
      # e.g. TyneCore::Foo => TyneCore::FooAuditFormatter
      def audit_formatter_class
        klass = self.auditable_type
        "#{klass}AuditFormatter".safe_constantize
      end

      # Proxy method for format on the formatter class.
      def formatted
        audit_formatter.format
      end

      # Proxy metho for details on the formatter class
      def details
        audit_formatter.details
      end

      # Returns an instance of formatter class.
      def audit_formatter
        @audit_formatter ||= audit_formatter_class.new(self)
      end
    end
  end
end

ActiveSupport.on_load(:active_record) do
  Audited::Adapters::ActiveRecord::Audit.send(:include, TyneCore::AuditFormatter::Support)
end
