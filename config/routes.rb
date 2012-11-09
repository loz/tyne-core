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
