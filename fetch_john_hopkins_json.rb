require 'net/http'
require 'json'
require 'csv'

def fetch_john_hopkins_json(url)
    request_uri = URI(url)
    request_response = Net::HTTP.get_response(request_uri)
    response_json = JSON.parse(request_response.body)

    countries = response_json["Countries"]
    
    us_data = countries.find { |country_data| 
        country_data["CountryCode"] == "US"
    } 

    us_data["TotalDeaths"]

    
    
end