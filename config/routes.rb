Rails.application.routes.draw do

  root 'home#index'

  resources :things

  devise_for :users #, :controllers => { :omniauth_callbacks => "callbacks" }
  devise_for :admins

end
