UrlShortener::Application.routes.draw do
  resources :urls, only: [:new, :create, :show]
  root 'urls#new'
  get '/:id', to: 'urls#show'
end
