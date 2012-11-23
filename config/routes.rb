TyneCore::Engine.routes.draw do
  scope "/admin" do
    resources :projects, :only => [:index, :create, :update, :destroy] do
      collection do
        get :github
        post :import
        get :dialog
      end
    end
  end

  resources :dashboards
end

Rails.application.routes.draw do
  get '/:user', :controller => 'tyne_auth/users', :action => :overview, :as => :overview
  get '/:user/:key', :controller => 'tyne_core/issues', :action => 'index', :as => :backlog
  scope '/:user/:key' do
    resources :issues, :controller => 'tyne_core/issues' do
      collection do
        get :dialog
      end
      member do
        get :workflow
      end

      resources :comments, :controller => 'tyne_core/comments'
    end
  end
end
