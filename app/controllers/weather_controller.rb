class WeatherController < ApplicationController

  def index
    @weather = Weather.new
    @current = Weather.last
  end

  def show
    @search = Weather.new(search_params)
    @search.save
    redirect_to :back
  end

  def search_params
  params.require(:weather).permit(:zipcode)
end
end
