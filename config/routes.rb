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
        post :reorder
      end

      member do
        get :workflow
        post :upvote
        post :downvote
        post :assign_to_me
      end

      resources :comments, :controller => 'tyne_core/comments'
    end

    resources :teams, :controller => 'tyne_core/teams' do
      resources :team_members, :controller => 'tyne_core/team_members'
    end

    resources :sprints, :controller => 'tyne_core/sprints' do
      member do
        post :reorder
        put :start
      end
    end
  end
end
