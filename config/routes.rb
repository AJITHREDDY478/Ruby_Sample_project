Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'urls#new'

  resources :urls, only: [:create, :show, :new, :edit, :update, :destroy], param: :short_url
  get ':short_url', to: 'urls#redirect', as: 'redirect'
  # Defines the root path route ("/")
  # root "articles#index"
end
