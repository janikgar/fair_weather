# Fair Weather

This is a basic app for checking the weather based on US ZIP code. It interfaces with the Open Weather API.

## Requirements
* Ruby 2.3.3
### Gems
* jquery-rails
* bootstrap-sass
* httparty
* figaro
### Development gems
* pry-rails
* better_errors
* binding_of_caller

## Running locally
You must request API credentials from Google Maps (for geolocation) and Open Weather API. After cloning and running `bundle install`, run `figaro install`. This will create `application.yml` in the `config` directory.

Add the following keys with your API credentials:
```
openweather_api_key: <your OpenWeather API key>
google_api_key: <your Google API key>
```

Then run `rails s` to run the app. Navigate to `localhost:3000` to run.