Rails.application.routes.draw do
  devise_for :users
  root to: 'users#index'
  resources :gifts do
    get :search, on: :collection
    resources :contributors do
      patch :pay, on: :member
    end
  end
  get 'users' => 'users#list'
end
