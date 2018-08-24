class WelcomeController < ApplicationController
  def test
  end

  def index
    # check state & city params are not empty
    if params[:zipcode] != '' && !params[:zipcode].nil?
      google_response_array = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{params[:zipcode]}&key=#{ENV['google_api_key']}")["results"][0]["address_components"]
      google_address = Hash.new
      google_response_array.each do |line|
        google_address[:zip] = line["short_name"] if line["types"].include?("postal_code")
        google_address[:city] = line["short_name"] if line["types"].include?("locality")
        google_address[:state] = line["short_name"] if line["types"].include?("administrative_area_level_1")
        google_address[:country] = line["short_name"] if line["types"].include?("country")
      end
      response = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?zip=#{params[:zipcode]}&units=imperial&appid=#{ENV['openweather_api_key']}")
      if @status != '404' && response['message'] != 'city not found'
        @zipcode = params[:zipcode]
        @location = google_address[:city]
        @state = google_address[:state]
        @country = google_address[:country]
        if (!City.pluck(:city).include?(@location)) && (!City.pluck(:city).include?(@country))
          City.create(zipcode: @zipcode, city: @location, state: @state, country: @country)
        end
        @temp = response['main']['temp']
        @weather_icon = response['weather'][0]['icon']
        @weather_words = response['weather'][0]['description']
        @cloudiness = response['clouds']['all']
        @windiness = response['wind']['speed']
      else
        @error = response['message']
      end
      # Or we can create a 'results' hash for each of these as well.
    end
  end
end
