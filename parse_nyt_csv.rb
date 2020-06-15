require 'net/http'
require 'csv'

def parse_nyt_csv(url)
    request_uri = URI(url)
    request_response = Net::HTTP.get_response(request_uri)

    csv_string = request_response.body
    csv_rows = CSV.parse(csv_string)

    header_row = csv_rows.first
    data_row = csv_rows.last

    death_count_col = header_row.index('deaths')
    
    return data_row[death_count_col].to_i
end