Rails.application.routes.draw do
  get 'posts/new'
  get 'posts/edit'
  get 'posts/index'
  get 'posts/show'
  get 'usernames/new'
  get 'usernames/index'
  get 'usernames/edit'
  get 'usernames/show'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  
 get 'post' => 'pages#post'

  get 'users' => 'users#index'
  get 'users/edit'
  get  'register' => 'users#new'
  get 'users/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'

  resources :users do
 delete 'delete' => 'users#destroy'
 resources :usernames do
    delete 'delete' => 'usernames#destroy'
    resources :posts do
       delete 'delete' => 'posts#destroy'
     end
  end
end

end
