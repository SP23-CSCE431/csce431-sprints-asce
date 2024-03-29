Rails.application.routes.draw do
  # <!-- these are routes for the event check in portion -->
  get 'pages/event_sign_in'
  post 'pages/event_check_in'
  # <!-- these are routes for the points reset portion -->
  get 'pages/reset_user_points' 
  post 'pages/reset_user_points' , to: 'pages#post_reset_user_points'
  # <!-- establishes that the sign in page will be the first page of the website -->
  root 'dashboards#show'
  #root 'users#index'
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end
  # <!-- /profile path will take users to their profile page -->
  match 'profile', to: 'users#profile', via: :get
  # <!-- /calendar path will take users to their personal calendar page -->
  get '/calendar(/:date)', to: 'user_events#calendar', as: 'calendar'
  # <!-- /profile path will take users to their profile page -->
  match 'my_events', to: 'user_events#my_events', via: :get
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # resources :user_events, :event_types, :events, :roles
  # Defines the root path route ("/")
  # <!-- This creates all the essential routes for the user_events entity -->
  # <!-- This gives the ability to create new, edit, or delete records of this entity -->
  resources :user_events do
    get :delete
  end
  # <!-- This creates all the essential routes for the events entity -->
  # <!-- This gives the ability to create new, edit, or delete records of this entity -->
  resources :events do
    get :delete
  end
  # <!-- This creates all the essential routes for the roles entity -->
  # <!-- This gives the ability to create new, edit, or delete records of this entity -->
  resources :roles
  # <!-- This creates all the essential routes for the users entity -->
  # <!-- This gives the ability to create new, edit, or delete records of this entity -->
  resources :users do
    member do
      get :delete
      get :search
      get :help
    end
  end
end
