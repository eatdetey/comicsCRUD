Rails.application.routes.draw do
  resources :comics
  resources :publishers
  resources :authors

  root 'pages#index'
end
