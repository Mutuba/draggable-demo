Rails.application.routes.draw do
  resources :todos do
    patch :sort, on: :collection
  end
  root "todos#index"
end
