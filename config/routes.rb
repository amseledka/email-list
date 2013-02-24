EmailLists::Application.routes.draw do
  root :to => 'subscribers#index'

  resources :subscribers do
    get 'url_parser', on: :collection
    post 'url_parser', on: :collection
  end
end
