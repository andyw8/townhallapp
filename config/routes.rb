Townhallapp::Application.routes.draw do
  root :to => "series#index"

  resources :series, :only => [:index, :create, :new]
end
