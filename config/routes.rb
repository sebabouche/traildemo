Rails.application.routes.draw do

  root 'home#index'

  resources :things do
    resources :comments
  end

  # devise_for :users #, :controllers => { :omniauth_callbacks => "callbacks" }
  devise_for :admins

end
