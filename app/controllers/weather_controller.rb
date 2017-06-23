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
           @date0 = @city['list'][0]['dt']
           @day0_date = Time.at(@date0).to_date.strftime("%m/%d")
           @day0 = @city['list'][0]['temp']['day']
           @day0_temp = ((1.8*(@day0-273))+32).floor
           @night0 = @city['list'][0]['temp']['night']
           @night0_temp = ((1.8*(@night0-273))+32).floor
           @day0_icon = @city['list'][0]['weather'][0]['icon']
           @day0_des = @city['list'][0]['weather'][0]['description']

           @date1 = @city['list'][1]['dt']
           @day1_date = Time.at(@date1).to_date.strftime("%m/%d")
           @day1 = @city['list'][1]['temp']['day']
           @day1_temp = ((1.8*(@day1-273))+32).floor
           @night1 = @city['list'][1]['temp']['night']
           @night1_temp = ((1.8*(@night1-273))+32).floor
           @day1_icon = @city['list'][1]['weather'][0]['icon']
           @day1_des = @city['list'][1]['weather'][0]['description']

           @date2 = @city['list'][2]['dt']
           @day2_date = Time.at(@date2).to_date.strftime("%m/%d")
           @day2 = @city['list'][2]['temp']['day']
           @day2_temp = ((1.8*(@day2-273))+32).floor
           @night2 = @city['list'][2]['temp']['night']
           @night2_temp = ((1.8*(@night2-273))+32).floor
           @day2_icon = @city['list'][2]['weather'][0]['icon']
           @day2_des = @city['list'][2]['weather'][0]['description']

           @date3 = @city['list'][3]['dt']
           @day3_date = Time.at(@date3).to_date.strftime("%m/%d")
           @day3 = @city['list'][3]['temp']['day']
           @day3_temp = ((1.8*(@day3-273))+32).floor
           @night3 = @city['list'][3]['temp']['night']
           @night3_temp = ((1.8*(@night3-273))+32).floor
           @day3_icon = @city['list'][3]['weather'][0]['icon']
           @day3_des = @city['list'][3]['weather'][0]['description']

           @date4 = @city['list'][4]['dt']
           @day4_date = Time.at(@date4).to_date.strftime("%m/%d")
           @day4 = @city['list'][4]['temp']['day']
           @day4_temp = ((1.8*(@day4-273))+32).floor
           @night4 = @city['list'][4]['temp']['night']
           @night4_temp = ((1.8*(@night4-273))+32).floor
           @day4_icon = @city['list'][4]['weather'][0]['icon']
           @day4_des = @city['list'][4]['weather'][0]['description']

           @date5 = @city['list'][5]['dt']
           @day5_date = Time.at(@date5).to_date.strftime("%m/%d")
           @day5 = @city['list'][5]['temp']['day']
           @day5_temp = ((1.8*(@day5-273))+32).floor
           @night5 = @city['list'][5]['temp']['night']
           @night5_temp = ((1.8*(@night5-273))+32).floor
           @day5_icon = @city['list'][5]['weather'][0]['icon']
           @day5_des = @city['list'][5]['weather'][0]['description']
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
