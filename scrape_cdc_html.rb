require 'nokogiri'
require 'net/http'

def scrape_cdc_html(url)
    request_uri = URI(url)
    request_response = Net::HTTP.get_response(request_uri)

    html_string = request_response.body
    html_data = Nokogiri::HTML.parse(html_string)

    html_data.css('.count').each do |element|
        label = element.previous_sibling.to_s
        if (label =~ /Total Deaths/) != nil
            return element.inner_html.tr('^0-9', '').to_i
        end
    end    

end