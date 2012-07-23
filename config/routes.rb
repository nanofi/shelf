Shelf::Application.routes.draw do
  resources :books do
    collection do
      post :search
    end
  end
  resources :relevants, only: [:create, :destroy]

  root to: 'books#index'
end
