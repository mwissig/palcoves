Rails.application.routes.draw do
  get 'pages/inbox'
  get 'pms/index'
  get 'pms/show'
  get 'comments/new'
  get 'comments/index'
  get 'comments/edit'
  get 'comments/show'
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
get 'inbox' => 'pages#inbox'
  get 'users' => 'users#index'
  get 'users/edit'
  get  'register' => 'users#new'
  get 'users/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'

  resources :users do
 delete 'delete' => 'users#destroy'
end

resources :usernames do
   delete 'delete' => 'usernames#destroy'
   resources :pms do
      delete 'delete' => 'pms#destroy'
    end
   resources :posts do
      delete 'delete' => 'posts#destroy'
      resources :comments do
         delete 'delete' => 'comments#destroy'
       end
    end
 end

end
