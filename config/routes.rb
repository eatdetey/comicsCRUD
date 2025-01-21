Rails.application.routes.draw do
  get '/comics', to: 'comics#index'
  root 'pages#index'
end
