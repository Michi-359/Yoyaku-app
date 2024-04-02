Rails.application.routes.draw do
  resources :rooms
  resources :reservations
  get "users/show" => "users#show"
  resources :profiles
  get "/search", to: "searches#top"
  root to: "searches#top"
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
