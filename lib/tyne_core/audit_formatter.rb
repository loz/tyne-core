module TyneCore
  module AuditFormatter
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

      def format
        raise NotImplementedError
      end

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

    module Support
      extend ActiveSupport::Concern

      def audit_formatter_class
        klass = self.auditable_type
        "#{klass}AuditFormatter".safe_constantize
      end

      def formatted
        audit_formatter.format
      end

      def details
        audit_formatter.details
      end

      def audit_formatter
        @audit_formatter ||= audit_formatter_class.new(self)
      end
    end
  end
end

ActiveSupport.on_load(:active_record) do
  Audited::Adapters::ActiveRecord::Audit.send(:include, TyneCore::AuditFormatter::Support)
end
