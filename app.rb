require "sinatra"
require "sinatra/reloader"
require "http"
require "dotenv/load"
require "json"

API_KEY = ENV.fetch("EXCHANGE_API")

get("/") do
  
  @currencies = JSON.parse(HTTP.get("https://api.exchangerate.host/list?access_key=#{API_KEY}"))

  erb(:currencies, { :layout => :layout })

end

get("/:from_c") do

  @from = params["from_c"]
  @currencies = JSON.parse(HTTP.get("https://api.exchangerate.host/list?access_key=#{API_KEY}"))

  erb(:symbol, {:layout => :layout} )

end

get("/:from_c/:to_c") do

  @from = params["from_c"]
  @to = params["to_c"]
  @amount = JSON.parse(HTTP.get("https://api.exchangerate.host/convert?access_key=#{API_KEY}&from=#{@from}&to=#{@to}&amount=1"))["result"]

  erb(:convert, {:layout => :layout} )

end
