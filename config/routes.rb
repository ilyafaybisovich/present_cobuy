Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    authenticated :user do
      root to: 'users#index', as: :authenticated_root
    end

    unauthenticated :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :gifts do
    get :search, on: :collection
    resources :contributors do
      patch :pay, on: :member
      resources :charges
    end
  end

  get 'users/:id' => 'users#show'
  root to: 'users#index'
end
