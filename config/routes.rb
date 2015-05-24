Rails.application.routes.draw do
  devise_for :users
  root to: 'users#index'
  resources :gifts do
    collection do
      get 'search'
    end
    resources :contributors do
      patch :pay, on: :member
    end
  end
  resources :gifts
  get 'gifts/search/:keyword' => 'gifts#search'
  get 'users' => 'users#list'
end
