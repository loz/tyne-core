require 'state_machine'
require 'tyne_ui'

module TyneCore
  # Core engine
  class Engine < ::Rails::Engine
    require 'sass-rails'
    config.sass.load_paths << File.expand_path('../../vendor/assets/stylesheets/')

    config.generators do |g|
      g.test_framework = :rspec
      g.integration_tool = :rspec
    end

    isolate_namespace TyneCore

    config.autoload_paths << File.expand_path('../../', __FILE__)
    Mime::Type.register_alias "text/html", :pjax

    initializer "tyne_auth.extensions" do
      ActionDispatch::Reloader.to_prepare do
        TyneAuth::User.send(:include, TyneCore::Extensions::User)
        TyneCore::ApplicationController.send(:include, TyneCore::Extensions::ActionController::Sorting)
        TyneCore::ApplicationController.send(:include, TyneCore::Extensions::ActionController::Filter)
        TyneCore::ApplicationController.send(:include, TyneCore::Extensions::ActionController::Pagination)
      end
    end
  end
end
