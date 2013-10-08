EmailLists::Application.routes.draw do
  root :to => 'subscribers#index'

  resources :subscribers do
    post 'url_parser', on: :collection
  end
end
