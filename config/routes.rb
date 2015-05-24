Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root to: 'users#index', as: :authenticated_root
    end

    unauthenticated :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :gifts do
    collection do
      get 'search'
    end
  end

  resources :gifts
  get 'gifts/search/:keyword' => 'gifts#search'
  get 'users' => 'users#list'
  get 'users/:id' => 'users#show'
  root to: 'users#index'
end
