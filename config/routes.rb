TyneCore::Engine.routes.draw do
  resources :projects do
    collection do
      get :github
      post :import
      get :dialog
    end
  end

  resources :dashboards
end

Rails.application.routes.draw do
  get '/:user', :controller => 'tyne_auth/users', :action => :overview, :as => :overview
  get '/:user/:key', :controller => 'tyne_core/issues', :action => 'index', :as => :backlog
  scope '/:user/:key' do
    get :admin, :controller => 'tyne_core/projects', :action => :admin, :as => :admin_project
    resources :issues, :controller => 'tyne_core/issues' do
      collection do
        get :dialog
      end

      member do
        post :assign_to_me
      end

      member do
        get :workflow
        post :upvote
        post :downvote
      end

      resources :comments, :controller => 'tyne_core/comments'
    end

    resources :teams, :controller => 'tyne_core/teams' do
      resources :team_members, :controller => 'tyne_core/team_members'
    end
  end
end
