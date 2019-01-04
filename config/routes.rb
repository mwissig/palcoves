Rails.application.routes.draw do
  get 'user/index'
  get 'user/edit'
  get 'user/new'
  get 'user/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
end
