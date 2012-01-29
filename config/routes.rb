require 'nabaztag_hack_kit/server'

Pinpirate::Application.routes.draw do

  resources :charts, :only => [:index]

  resources :players, :only => [:create, :update]

  resources :events, :only => [:create]

  resources :games, :only => [:index, :show]

  get "button" => "games#button"

  mount NabaztagHackKit::Server.new => "/"

  root :to => "games#index"
end

