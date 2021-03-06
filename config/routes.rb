Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #pages controller, home action
  root 'pages#home'

  # pages controller, about action
  get 'about', to: 'pages#about'

  resources :articles

  get 'signup', to: 'users#new'

  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :categories, except: [:destroy]

end
