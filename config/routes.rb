Townhallapp::Application.routes.draw do

  devise_for :users

  root :to => "series#index"

  resources :series, :only => [:index, :create, :new, :show] do
    resources :submissions, :only => [:new, :create, :index]
  end
end
