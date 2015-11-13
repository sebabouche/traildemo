Rails.application.routes.draw do

  root 'home#index'

  resources :things do
    resources :comments
    member do
      post :create_comment
    end
  end

  # devise_for :users #, :controllers => { :omniauth_callbacks => "callbacks" }
  devise_for :admins

end
