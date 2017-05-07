Rails.application.routes.draw do

  get 'notifications/index'

  namespace :api,  defaults: { format: :json } do
    namespace :v1 do
      get '/users/search', to: 'users#search'
      post 'places/user', to: 'places#user_places'
      get 'places/experts', to: 'places#filter_by_expert'
      get 'places/friends', to: 'places#filter_by_friends'
      get 'places/types', to: 'places#filter_by_types'
      post 'places/image', to: 'places#images'
      get 'places/search', to: 'places#filter_by_city_or_country'
      resources :users
      resources :places

      get 'feed', to: "feeds#index"
      get 'feed/friends', to: 'feeds#feed_by_friends'
      get 'feed/experts', to: 'feeds#feed_by_experts'
      get 'feed/users/:user_id', to: 'feeds#feed_by_user'

      get 'friends', to: 'friends#index'
      post 'friends', to: 'friends#create'
      post 'friends/accept', to: 'friends#accept'
      post 'friends/decline', to: 'friends#decline'
      get 'friends/requested', to: 'friends#requested_friends'
      get 'friends/pending', to: 'friends#pending_friends'
      get 'friends/users/:user_id', to: 'friends#requested_friends_of_user'

      get 'groups', to: 'groups#my_groups'
      get 'groups/private', to: 'groups#private_groups'
      get 'groups/public', to: 'groups#public_groups'
      post 'groups/public', to: 'groups#join_public_group'
      post 'groups/private', to: 'groups#request_join_private_group'
      post 'groups', to: 'groups#create'
      get 'groups/search', to: 'groups#search'
      get 'groups/places', to: 'groups#group_places'
      post 'groups/friends', to: 'groups#add_friends'
      post 'groups/accept', to: 'groups#accept_join_private_group'

      get 'notifications', to: 'notifications#index'
      post 'notifications/like', to: 'notifications#create_like'
      get 'notifications/likes', to: 'notifications#likes_index'
      post 'notifications/been_there', to: 'notifications#been_there'
    end
  end
end
