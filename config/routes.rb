Rails.application.routes.draw do

  resources :games do
    get :qrcodes, on: :collection
    get :show_img, on: :member
    resources :reactions do
      get :toggle, on: :collection
    end
    resources :comments
    get  :edit_pinnings, on: :member
    post :pinnings, on: :member
  end

  resources :users do
    get :myedit, on: :collection
    put :myupdate, on: :collection
  end
  resources :comments

  get 'login',                       to: 'logins#index',  as: :login
  get 'logins/logout',               to: 'logins#logout', as: :logout
  get 'auth/google_oauth2',          as: 'google_login'
  get 'auth/google_oauth2/callback', to: 'logins#google_oauth2'

  get 'ping', to: 'home#ping', as: :ping
  root to: 'home#index'
end
