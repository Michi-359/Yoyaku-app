Rails.application.routes.draw do
  resources :rooms
  resources :reservations
  get "users/show" => "users#show"
  get "/search", to: "searches#top"
  root to: "searches#top"
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get "users/profile" => "users#edit"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
