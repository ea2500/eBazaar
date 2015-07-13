require "faraday"
require "json"

query=%w{fuzzy monkey}.join('%20')

p url="https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=#{query}"
conn=Faraday.new
response=conn.get(url)
p response.satatus

parsed=JSON.load(content.body)
p parsed
