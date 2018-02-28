Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :start
  resources :users
  resources :devise
  resources :chats

  authenticated :user do
  	root 'start#index'
  end
 unauthenticated :user do
 	devise_scope :user do
 		root 'start#unsigned', as: :unregistered_root
 	end
 end
end
