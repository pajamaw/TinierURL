Rails.application.routes.draw do

  root 'short_link#new'
  #/i/ for internal
  get '/i/', to: 'short_link#index', as: 'short_links'
  get '/:slug', to: 'short_link#show', as: 'short_link'
  #/a/ for apoco customer
  get '/a/:custom_slug', to: 'short_link#custom_show', as: 'custom_short_link'

  post '/bv/', to: 'short_link#create', as: 'create_short_link'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
