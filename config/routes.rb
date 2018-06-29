Rails.application.routes.draw do
  root 'customers#main'

  get 'pages/login'
  get 'pages/logout'
  get 'pages/unauthorized'

  get 'customers/main'
  get 'customers/search'
  get 'customers/export'
  post 'customers/export', to: 'customers#export'

  get 'login', to: redirect('/auth/google_oauth2'), as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'auth/google_oauth2/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
end
