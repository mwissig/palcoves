Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
 get '/:token/confirm_email/', :to => "users#confirm_email", as: 'confirm_email'
    get 'usernames/:id/archive' => 'usernames#archive', :as => :archive
    get 'usernames/:id/gallery' => 'usernames#gallery', :as => :gallery
  get 'search' => 'pages#search'
  get 'results' => 'pages#results'
  post 'results' => 'pages#search'
  get 'css' => 'pages#css'
  get 'inbox' => 'pages#inbox'
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

  resources :pages do
    collection do
      get :markallread
    end
  end

  resources :users do
 delete 'delete' => 'users#destroy'
 member do
  get :confirm_email
end
end

resources :usernames do
   delete 'delete' => 'usernames#destroy'
   resources :pms do
      delete 'delete' => 'pms#destroy'
    end
    resources :notifications do
       delete 'delete' => 'notifications#destroy'
     end
    resources :userstyles do
       delete 'delete' => 'userstyles#destroy'
     end
     resources :follows do
        delete 'delete' => 'follows#destroy'
      end
   resources :posts do
      delete 'delete' => 'posts#destroy'
      resources :comments do
         delete 'delete' => 'comments#destroy'
       end
    end
 end

resources :password_resets,     only: [:new, :create, :edit, :update]

end
