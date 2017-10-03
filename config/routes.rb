Rails.application.routes.draw do

  root 'short_links#index'
  get '/:slug', to: 'short_links#show', as: 'short_link'
  post '/t/', to: 'short_links#create', as: 'short_links'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
