Rails.application.routes.draw do
  root 'dashboards#show'
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # resources :user_events, :event_types, :events, :roles
  # Defines the root path route ("/")
  # root 'users#index'
  # root "articles#index"
  resources :users do
    member do
      get :delete
    end
  end
end
