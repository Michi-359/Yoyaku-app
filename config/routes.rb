Rails.application.routes.draw do
  get 'users/show'
  resources :rooms
  resources :reservations
  root to: 'rooms#index' 
  get "users/show" => "users#show"
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get "users/profile" => "users#show"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
