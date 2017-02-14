Rails.application.routes.draw do



  namespace :api,  defaults: { format: :json } do
    namespace :v1 do
      resources :users
      resources :places
      get 'feed', to: "feeds#index"

    end
  end
end
