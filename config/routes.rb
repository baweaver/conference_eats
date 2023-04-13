Rails.application.routes.draw do
  resources :gatherings, except: %i[create new update edit destroy] do
    resources :outings do
      post :join

      # Other actions are handled by the outing or by an admin
      resources :groups, except: %i[index new create destroy]
    end
  end

  mount RailsEventStore::Browser => '/res' if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "gatherings#index"
end
