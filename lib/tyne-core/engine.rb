module TyneCore
  class Engine < ::Rails::Engine
    isolate_namespace TyneCore

    config.generators do |g|
      g.test_framework :rspec
      g.integration_tool :rspec
    end
  end
end
