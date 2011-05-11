Townhallapp::Application.routes.draw do

  devise_for :users

  root :to => "series#index"

  resources :series, :only => [:index, :create, :new]
end
