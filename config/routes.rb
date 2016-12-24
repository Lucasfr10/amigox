Rails.application.routes.draw do
  resources :events
  resources :groups
  resources :users
  root "users#index"

  get '/login' => 'users#login'
  post '/sing_up' => 'users#sing_up'
  get '/logout' => 'users#logout'

  get '/accept_invite/:user_id/:group_id' => "groups#accept_invite"
  get '/recuse_invite/:user_id/:group_id' => "groups#recuse_invite"

  post '/send_message' => "users#send_message", defaults: { format: 'json' }
  get '/get_messages/:id' => "users#get_messages", defaults: { format: 'json' }
end
