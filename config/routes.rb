Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :user_events, :event_types, :events, :roles
  # Defines the root path route ("/")
  root 'users#index'
  # root "articles#index"
  resources :users do
    member do
      get :delete
    end
  end
end
