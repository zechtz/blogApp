Blog::Application.routes.draw do
  root :to => 'home#index'
  get 'sign_up' => 'users#new', :as => 'sign_up'
  get 'log_in' => 'sessions#new', :as => 'log_in'
  get 'log_out' => 'sessions#destroy', :as => 'log_out'
  get 'manage_users' => 'users#index', :as => 'manage_users'
  get 'add_post' => 'posts#new', :as => 'add_post'
  get 'refresh_posts' => 'home#refresh_posts', :as => 'refresh_posts'
  resources :posts
  

  # users resource 
  resources :users do 
  	member do 
       match 'set_as_admin', 
                                    :via => [:post, :get]
       get 'pending_requests' => 'friendships#pending_friendships', 
                                    :as => 'pending_requests'
       match 'add_friend' => 'friendships#accept_friendship_request', 
                                    :as => 'add_friend', 
                                    :via => [:post, :get]
       get 'browse_people' => 'friendships#index', 
                                    :as => 'browse_people'
       match 'request_friendship' => 'friendships#create', 
                                    :as => 'request_friendship', 
                                    :via => [:post,:get]
       match 'reject_friendship' => 'friendships#reject_friendship', 
                                    :as => 'reject_friendship', 
                                    :via => [:post, :get]
       get 'friends' => 'friendships#show_friends',
                                    :as => 'friends'
       match 'unfriend' => 'friendships#destroy_friendship',
                                    :as => 'unfriend', :via => [:post]                             
    end
  end
 # end users resource

  resources :sessions
  resources :comments, :only => [:index]
end
