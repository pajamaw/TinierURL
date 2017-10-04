Rails.application.routes.draw do

  root 'short_link#index'
  get '/:slug', to: 'short_link#show', as: 'short_link'
  post '/bv/', to: 'short_link#create', as: 'create_short_link'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
