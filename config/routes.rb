Pinpirate::Application.routes.draw do
  resources :charts, :only => [:index]

  resources :players, :only => [:create, :update]
  resources :events, :only => [:create]

  resources :games, :only => [:index, :show]

  root :to => "games#index"
end

