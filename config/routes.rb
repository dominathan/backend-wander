Rails.application.routes.draw do

  namespace :api,  defaults: { format: :json } do
    namespace :v1 do
      get '/users/search', to: 'users#search'
      resources :users
      resources :places
      get 'feed', to: "feeds#index"
      get 'friends', to: 'friends#index'

    end
  end
end
