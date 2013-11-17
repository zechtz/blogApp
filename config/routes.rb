Blog::Application.routes.draw do
  root :to => 'home#index'
  get 'sign_up' => 'users#new', :as => 'sign_up'
  get 'log_in' => 'sessions#new', :as => 'log_in'
  get 'log_out' => 'sessions#destroy', :as => 'log_out'
  get 'manage_users' => 'users#index', :as => 'manage_users'
  get 'add_post' => 'posts#new', :as => 'add_post'
  resources :posts
  
  # users resource 
  resources :users do 
  	member do 
       match 'set_as_admin', :via => [:post, :get]
       get 'pending_requests' => 'users#pending_friendships', :as => 'pending_requests', :via => [:get]
       match 'add_friend' => 'users#accept_friendship_request', 
       :as => 'add_friend', :via => [:post, :get]
       get 'browse_people' => 'friendships#index', :as => 'browse_people', :via =>[:get]
       match 'request_friendship' => 'friendships#create', 
       :as => 'request_friendship', :via => [:post,:get]
       match 'reject_friendship' => 'friendships#reject_friendship', :as => 'reject_friendship', :via => [:post, :get]
    end
  end
 # end users resource

  resources :sessions
  resources :comments
end
