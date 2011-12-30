Pinpirate::Application.routes.draw do

  resources :players, :only => [:update]

  resources :games, :only => [:index, :create] do
    resources :events, :only => [:create]
    resources :score_events, :only => [:create], :path => 'scores'
  end

  root :to => "games#index"
end

