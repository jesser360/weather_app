class WeatherController < ApplicationController
  require 'httparty'
  include HTTParty

  def index
    @weather = Weather.new
    @recent = Weather.last
    if @recent
    @second_recent = Weather.find_by_id(@recent.id-1)
    end
    if @second_recent
    @third_recent = Weather.find_by_id(@recent.id-2)
    end
  end

  def create
    @search = Weather.new(search_params)
    if @search.save
      redirect_to weather_path_url(@search)
    else
      flash[:error] = @search.errors.full_messages.join(", ")
      redirect_to :back
    end
  end

  def show
    @current = Weather.find_by_id(params[:id])
    @zipcode = @current.zipcode
      weather_hash = fetch_weather(@zipcode)
      assign_values(weather_hash)
  end

  def initialize
  end

  def fetch_weather zipcode
    @response = HTTParty.get("http://api.openweathermap.org/data/2.5/forecast/daily?zip=#{zipcode}&cnt=6&APPID=56816b6400cf26a5068b34d20251372f")
  end


  def assign_values(weather_hash)
    require 'date'
    @cached = Rails.cache.fetch("#{@zipcode}", expires_in: 30.minutes) do
      @city = weather_hash.parsed_response
    end
      if (weather_hash.parsed_response['city'])
           @city_name = @city['city']['name']
           @total_days = []
           $i = 0
           $total = 5
           while $i <= $total do
            @day = {}
            @day[:date] = @city['list'][$i]['dt']
           @day[:format_date] = Time.at(@day[:date]).to_date.strftime("%m/%d")
           @day[:day] = @city['list'][$i]['temp']['day']
           @day[:day_temp] = ((1.8*(@day[:day]-273))+32).floor
           @day[:night] = @city['list'][$i]['temp']['night']
           @day[:night_temp] = ((1.8*(@day[:night]-273))+32).floor
           @day[:icon] = @city['list'][$i]['weather'][0]['icon']
           @day[:description] = @city['list'][$i]['weather'][0]['description']
           @total_days.push(@day)
           $i+=1
         end
      else
        redirect_to :back
        flash[:error] = "Not a valid USA zip code"
      end

   end

  def search_params
  params.require(:weather).permit(:zipcode)
end


def initialize
end

end
