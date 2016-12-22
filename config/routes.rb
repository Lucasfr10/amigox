Rails.application.routes.draw do
  resources :groups
  resources :users
  root "users#index"

  get '/login' => 'users#login'
  post '/sing_up' => 'users#sing_up'
end
