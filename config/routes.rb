Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :start

  authenticated :user do
  	root 'start#index'
  end
 unauthenticated :user do
 	devise_scope :user do
 		root 'start#unsigned', as: :unregistered_root
 	end
 end


 resources :chats, only: [:index, :create] do
    resources :messages
  end

  resources :users, only: [:index]
end
