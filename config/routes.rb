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
      post 'friends/decline', to: 'friends#decline'
      get 'friends/requested', to: 'friends#requested_friends'
      get 'friends/pending', to: 'friends#pending_friends'
      get 'groups', to: 'groups#my_groups'
      get 'groups/private', to: 'groups#private_groups'
      get 'groups/public', to: 'groups#public_groups'
      post 'groups/public', to: 'groups#join_public_group'
      post 'groups/private', to: 'groups#join_private_group'
      post 'groups', to: 'groups#create'
      get 'groups/search', to: 'groups#search'
    end
  end
end
