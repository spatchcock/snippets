# jcode not needed in Ruby 1.9 but is required by the standard gdata gem
# This version has been updated for ruby 1.9
#
# gem 'gdata', git: 'https://github.com/agentrock/gdata.git'

require 'rubygems'
require 'gdata/client'  
require 'gdata/http'  
require 'gdata/auth'
require 'csv'

email    = #<ADD_EMAIL>
password = #<ADD_PASSWORD>

key    = #<ADD_DOCUMENT_KEY> 'key' query parameter
tab    = #<ADD_TAB_INDEX>     index of required tab, if omitted from url, defaults to 0 (i.e. first tab)
format = #<ADD_FORMAT>        e.g. "csv" or "xls"
url    = "https://spreadsheets.google.com/feeds/download/spreadsheets/Export?key=#{key}&gid=#{tab}&fmcmd&exportFormat=#{format}"

client = GData::Client::Spreadsheets.new  # Instantiate object 
client.clientlogin(email, password)       # authenticate
doc = client.get(url)                     # get document

# remove trailing whitespace
csv = CSV.parse(doc.body).map do |row| 
  row.map { |field| field.strip unless field.nil? }
end

# do stuff with data

# or just write to file
CSV.open("data.#{format}", "wb") do |file| 
  csv.each { |row| file << row }
end