require_relative "CSVDownloader"

CDC_STAT_COL = 1
NYT_STAT_COL = 2
DATE_COL = 0

CDC_DATASET_URL = 'https://www.cdc.gov/nchs/nvss/vsrr/covid19/data/COVID19_3.0_daily.csv' 
NYT_DATASET_URL = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us.csv'

cdc = CSVDownloader.new(CDC_DATASET_URL)
cdc.download("CDC_DATASET")
nyt = CSVDownloader.new(NYT_DATASET_URL)
nyt.download("NYT_DATASET")

cdc_dataset_stat_row = 1
cdc_dataset_date_row = cdc.csv_rows.length - 1
latest_cdc_date = DateTime.parse(cdc.csv_rows[cdc_dataset_date_row][DATE_COL])

nyt_dataset_stat_row = nyt.csv_rows.length - 1
nyt_dataset_date_row = nyt.csv_rows.length - 1
latest_nyt_date = DateTime.parse(nyt.csv_rows[nyt_dataset_date_row][DATE_COL])

latest_available_date = latest_cdc_date == latest_nyt_date ? latest_cdc_date : nil


while latest_available_date == nil
    
    if latest_cdc_date > latest_nyt_date
        cdc_dataset_date_row -= 2
        while latest_cdc_date > latest_nyt_date
            latest_cdc_date = DateTime.parse(cdc.csv_rows[cdc_dataset_date_row][DATE_COL])
            cdc_dataset_date_row -= 1
        end
        cdc_dataset_stat_row = cdc_dataset_date_row
    elsif latest_nyt_date > latest_cdc_date
        nyt_dataset_date_row -= 1
        while latest_nyt_date != latest_cdc_date
            latest_nyt_date = DateTime.parse(nyt.csv_rows[decrement].first)
            nyt_dataset_date_row -= 1
        end
        nyt_dataset_stat_row = nyt_dataset_date_row
    end

    if latest_cdc_date == latest_nyt_date
        latest_available_date = latest_cdc_date
    end

end


cdc_death_toll = cdc.csv_rows[cdc_dataset_stat_row][CDC_STAT_COL].to_i
nyt_death_toll = nyt.csv_rows[nyt_dataset_stat_row][NYT_STAT_COL].to_i

puts latest_available_date
puts "CDC #{ cdc_death_toll }"
puts "New York Times #{ nyt_death_toll }"

puts "Difference #{ cdc_death_toll - nyt_death_toll } "


