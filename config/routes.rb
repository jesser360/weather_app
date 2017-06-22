Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/' => 'weather#index'
  post '/weather', to: 'weather#create', as: 'create_weather_path'
  get '/weather/show/:id', to: 'weather#show', as:'weather_path'

end
