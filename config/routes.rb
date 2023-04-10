Rails.application.routes.draw do
  resources :gatherings, except: %i[create new update edit destroy] do
    resources :outings do
      resources :groups
    end
  end

  mount RailsEventStore::Browser => '/res' if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "homepage#index"
end
