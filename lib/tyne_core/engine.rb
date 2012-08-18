module TyneCore
  class Engine < ::Rails::Engine
    isolate_namespace TyneCore

    config.generators do |g|
      g.test_framework :rspec
      g.integration_tool :rspec
    end

    config.autoload_paths << File.expand_path('../../', __FILE__)
  end
end
