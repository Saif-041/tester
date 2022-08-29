Rails.application.routes.draw do
  
  devise_for :users,
  controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }

  post '/api/login', to: "session#create", as: "login"
  post '/api/register', to: "registration#create", as: "register"
  delete '/api/logout', to: "session#destroy", as: "logout"

  
  get 'api/getTime', to: "utc#time", as: "time"
  get 'api/getUserInformation', to: "utc#user", as: "user"
  
  # get '/api/getTim', to: proc { [200, {}, [ DateTime.now.utc.to_s + ' ' + Time.now.strftime("%H:%M").to_s + ' .. ' + DateTime.now.getutc.to_s + '  .. ' + Time.now.utc.to_s + ' ..  ' + DateTime.now.new_offset.to_s + ' ..  ' + Time.utc(*Time.now.to_a).to_s ]] }
  
  # devise_for :users
  # namespace :api do
  #   namespace :v1 do
  #     resources :posts
  #   end
  # end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

