TyneCore::Engine.routes.draw do
  resources :projects do
    collection do
      get :github
      post :import
    end
  end
end
