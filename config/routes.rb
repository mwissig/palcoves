Rails.application.routes.draw do
  get 'usernames/new'
  get 'usernames/index'
  get 'usernames/edit'
  get 'usernames/show'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'


  get 'users' => 'users#index'
  get 'users/edit'
  get  'register' => 'users#new'
  get 'users/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'

  resources :users do
 delete 'delete' => 'users#destroy'
end

end
