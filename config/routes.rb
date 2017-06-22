Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/' => 'weather#index'
  post '/weather', to: 'weather#show', as: 'create_weather_path'

end
