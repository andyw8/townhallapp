Townhallapp::Application.routes.draw do
  resources :series, :only => [:index, :create, :new]
end
