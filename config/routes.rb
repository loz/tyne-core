TyneCore::Engine.routes.draw do
  resources :projects, :only => [:index, :create, :update, :destroy] do
    collection do
      get :github
      post :import
      get :dialog
    end
  end
end
