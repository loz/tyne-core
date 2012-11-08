TyneCore::Engine.routes.draw do
  resources :projects do
    collection do
      get :github
      post :import
      get :dialog
    end
  end
end
