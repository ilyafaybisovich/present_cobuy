Rails.application.routes.draw do
  devise_for :users
  root to: 'users#index'
  resources :gifts do
    collection do
      get 'search'
    end
  end
  resources :gifts
  get 'gifts/search/:keyword' => 'gifts#search'
  get 'users' => 'users#list'
  get 'users/:id' => 'users#show'
end
