Rails.application.routes.draw do


  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  devise_for :users #, :controllers => { :omniauth_callbacks => "callbacks" }
  devise_for :admins

  root 'pages#home'

end
