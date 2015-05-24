Rails.application.routes.draw do
  devise_for :user
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  resources :gifts do
    collection do
      get 'search'
    end
  end
  resources :gifts
  get 'gifts/search/:keyword' => 'gifts#search'
  get 'users' => 'users#list'
end
