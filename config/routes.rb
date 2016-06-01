Rails.application.routes.draw do
  
  devise_for :users
  resources :articles
  match 'home', to: 'articles#home', via: 'get'
  root 'articles#home'
  
end
