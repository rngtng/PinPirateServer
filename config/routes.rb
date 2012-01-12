Pinpirate::Application.routes.draw do

  resources :charts, :only => [:index]

  resources :players, :only => [:create, :update]
  post "/vl/players" => "players#show"

  resources :events, :only => [:create]
  post "/vl/events" => "events#create"

  resources :games, :only => [:index, :show]

  get "/vl/bc"



  root :to => "games#index"
end

