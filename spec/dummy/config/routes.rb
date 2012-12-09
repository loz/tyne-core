Rails.application.routes.draw do
  mount TyneCore::Engine   => "/core"
  mount Evergreen::Railtie => '/evergreen' if Rails.env.test?

  root :to => "tyne_core/projects#index"
end
