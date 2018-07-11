Rails.application.routes.draw do
<<<<<<< HEAD
  root 'customers#index'
  get 'customers/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
=======
  root 'pages#login'
>>>>>>> ce5c857d358b36abc350fc2fb1c1032e32ba2bd2

  get 'pages/login'
  get 'pages/logout'
  get 'pages/unauthorized'

  get 'customers/index'
  get 'customers/main'
  get 'customers/search'
  get 'customers/export'
  post 'customers/export', to: 'customers#export'

  get 'login', to: redirect('/auth/google_oauth2'), as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'auth/google_oauth2/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
end
