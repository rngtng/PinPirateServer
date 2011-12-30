Pinpirate::Application.routes.draw do

  resources :games do
    resources :events, :only => [:create]
    match "scores" => "events#create", :defaults => { :type => "ScoreEvent" }
  end

  root :to => "games#index"
end

