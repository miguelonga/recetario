Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :users
  resources :recipes do
  	member do
  		put "like", to: "recipes#upvote"
  	end
  end

  get 'misrecetas' => "recipes#creador"
  get 'grupos' => "recipes#group_index"
  get 'tags/:tag', to: 'recipes#indexin', as: :tag

  root "recipes#index"
end
