Rails.application.routes.draw do
  
  devise_for :users,
  controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }
  
  # devise_for :user, 
  # :path => '', 
  # :path_names => { 
  #   :sign_in => "login", 
  #   :sign_out => "logout", 
  #   :sign_up => "register" 
  # }


  # devise_scope :user do
  #   post '/api/register', to: "users/registrations#create"
  #   post '/api/login', to: "users/sessions#create"
  #   delete '/api/logout', to: "users/sessions#destroy"
  # end

  # post '/api/register', to: "users/registrations#create"
  # post '/api/login', to: "users/sessions#create", as: "user_session"
  # delete '/api/logout', to: "session#destroy", as: "logout"
  
  get '/api/getTime', to: "utc#time", as: "time"
  get '/api/testUTC', to: "utc#test", as: "testUTC"

  get '/api/getUserInformation', to: "getuserinformation#show", as: "user"

  post '/api/castVote', to: "votes#castvote", as: "castVote"

  post '/api/updatePaymentStatus', to: "updatepayment#update", as: "updatePayment"

  post '/api/registerPoll', to: "poll#create", as: "registerPoll"
  get '/api/getActivePolls', to: "poll#index", as: "ShowCurrentPoll"

  get '/api/getNGOs', to: "ngo#index", as: "getNGOs"

  post '/api/createFeedback', to: "feedback#create", as: "createFeedback"
  get '/api/getFeedback', to: "feedback#index", as: "getFeedback"
  
  get "/api/getDropLocations", to:"drop#show", as: "getDropLocations"
  
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

