Rails.application.routes.draw do

  namespace :api,  defaults: { format: :json } do
    namespace :v1 do
      get '/users/search', to: 'users#search'
      resources :users
      resources :places
      post 'places/user', to: 'places#user_places'
      get 'feed', to: "feeds#index"
      get 'feed/friends', to: 'feeds#feed_by_friends'
      get 'feed/experts', to: 'feeds#feed_by_experts'
      get 'feed/users', to: 'feeds#feed_by_user'
      get 'friends', to: 'friends#index'
      post 'friends', to: 'friends#create'
      post 'friends/accept', to: 'friends#accept'
      get 'friends/requested', to: 'friends#requested_friends'
      get 'friends/pending', to: 'friends#pending_friends'
      post 'groups', to: 'groups#create'
    end
  end
end
