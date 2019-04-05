Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'

  resources :games do
    get :qrcodes, on: :collection
    resources :reactions do
      get :toggle, on: :collection
    end
  end

  root to: 'home#index'
end
