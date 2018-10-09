Rails.application.routes.draw do
  # get 'sessions/new'

  # get 'sessions/destroy'

  resources :sessions, only: [:new, :create, :destroy]

  get 'welcome/index'
  root 'welcome#index'

  resources :users
  resources :quizzes
  resources :notes
  
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
