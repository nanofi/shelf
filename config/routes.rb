Shelf::Application.routes.draw do
  resources :places, only: [:index, :show, :create, :destroy]
  resources :books do
    collection do
      get :search
    end
  end
  resources :relevants, only: [:create, :destroy]
  resources :entities, only: [:create, :update]

  root to: 'books#index'
end
