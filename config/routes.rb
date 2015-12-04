Rails.application.routes.draw do

    root 'todos#show'    
#    root 'sessions#new'
  
    get 'signup' => 'users#new'

    get 'todos' => 'todos#show'
    get 'todos/new' => 'todos#new'
    post 'todos/create' => 'todos#create'
#    get 'todos/index' => 'todos#index' # Admin Only
    
    get 'health' => 'health#index'

    get 'login' => 'sessions#new'
    get 'logout' => 'sessions#destroy'
    get 'users' => 'users#index' # Admin Only

    post 'login' => 'sessions#create'

    delete 'logout' => 'sessions#destroy'
 
    resources :health, :login, :users, :todos
end
