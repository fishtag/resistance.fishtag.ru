Rails.application.routes.draw do
  root to: 'game_sessions#index'

  resources :game_sessions
end
