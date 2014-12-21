Rails.application.routes.draw do
  devise_for :users
  resources :recipes do
  	member do
  		put "like", to: "recipes#upvote"
  	end
  end

  get 'misrecetas' => "recipes#creador"
  get 'grupos' => "recipes#group_index"

  root "recipes#index"
end
