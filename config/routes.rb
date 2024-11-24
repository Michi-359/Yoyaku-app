Rails.application.routes.draw do
  resources :profiles
  get "users/show" => "users#show"
  get "/search", to: "searches#search"
  get "/keyword_search", to: "searches#keyword_search"
  get "/reservations/confirm", to: "reservations#confirm"
  get "/reservations/:id/edit_confirm", to: "reservations#edit_confirm"
  root to: "searches#top"
  resources :rooms
  resources :reservations, only: [:index, :new, :confirm, :create, :show, :edit, :destroy, :update] do
    collection do
      post :confirm
    end
    member do
      patch :edit_confirm
    end
  end
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
