Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tenants do
    resources :properties
    get '/properties-published/', to: 'properties#index_published'
  end
end
