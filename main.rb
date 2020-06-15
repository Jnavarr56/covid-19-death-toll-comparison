require_relative "scrape_cdc_html"
require_relative "parse_nyt_csv"
require_relative "fetch_john_hopkins_json"

CDC_HTML_URL = 'https://www.cdc.gov/coronavirus/2019-ncov/cases-updates/cases-in-us.html'
cdc_death_count = scrape_cdc_html(CDC_HTML_URL)

NYT_CSV_URL = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/live/us.csv'
nyt_death_count = parse_nyt_csv(NYT_CSV_URL)

JOHN_HOPKINS_JSON_URL = 'https://api.covid19api.com/summary'
john_hopkins_death_count = fetch_john_hopkins_json(JOHN_HOPKINS_JSON_URL)


puts "CDC Death Count: #{cdc_death_count}"
puts "NYT Death Count: #{nyt_death_count}"
puts "John Hopkins Death Count: #{john_hopkins_death_count}"
