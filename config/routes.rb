Shelf::Application.routes.draw do
  resources :books do
    collection do
      post :search
    end
  end

  root to: 'books#index'
end
