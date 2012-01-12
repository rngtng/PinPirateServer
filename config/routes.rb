Pinpirate::Application.routes.draw do

  resources :charts, :only => [:index]

  resources :players, :only => [:create, :update]
  put "/vl/players/:id" => "players#update"

  resources :events, :only => [:create]
  post "/vl/events" => "events#create"

  resources :games, :only => [:index, :show]

  get "/vl/bc"
  get "/vl/debug"

  root :to => "games#index"
end

