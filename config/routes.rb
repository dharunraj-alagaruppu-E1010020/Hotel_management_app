Rails.application.routes.draw do
 # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/") 
  
  get '/users',to: 'user#index'

  get '/roles', to: 'user#list_of_role'

  post '/users' , to: 'user#create_user'

  post 'login', to: 'user#login'

  post '/restaurants', to: 'restaurant#create'

  get '/restaurants', to: 'restaurant#index'

  get '/restaurants/:id', to: 'restaurant#show', id: /[a-zA-Z0-9]+/

  put '/restaurants/:id', to: 'restaurant#update'

  delete '/restaurants/:id', to: 'restaurant#destroy'

  resources :user do
    member do
      get :history
    end
  end
  
  resources :restaurant do
    member do
      get :list_of_restaurant 
      get :show
      put :update
      get :delete_restaurant
    end
  end

  resources :table_restaurant do
    member do
      post :add_table
      get :list_table_available
    end
  end

  resources :table_booking do
    member do
      post :book_table
      patch :cancel_table
    end
  end

end