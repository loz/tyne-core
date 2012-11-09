module TyneCore
  # Core engine
  class Engine < ::Rails::Engine
    isolate_namespace TyneCore

    config.autoload_paths << File.expand_path('../../', __FILE__)

    initializer "tyne_auth.extensions" do
      ActionDispatch::Reloader.to_prepare do
        TyneAuth::User.send(:include, TyneCore::Extensions::User)
      end
    end
  end
end
