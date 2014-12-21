Rails.application.routes.draw do
  devise_for :users
  resources :recipes

  get 'misrecetas' => "recipes#creador"

  root "recipes#index"
end
