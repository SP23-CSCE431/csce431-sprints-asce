Rails.application.routes.draw do
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
  get '/calendar(/:date)', to: 'events#calendar', as: 'calendar'
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
    end
  end
end
