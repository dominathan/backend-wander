Rails.application.routes.draw do

  namespace :api,  defaults: { format: :json } do
    namespace :v1 do
      get '/users/search', to: 'users#search'
      resources :users
      resources :places
      get 'feed', to: "feeds#index"
      get 'feed/friends', to: 'feeds#feed_by_friends'
      get 'feed/experts', to: 'feeds#feed_by_experts'
      get 'friends', to: 'friends#index'
      post 'friends', to: 'friends#create'
    end
  end
end
