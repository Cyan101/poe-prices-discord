require 'json';
require 'rest-client'

POE_ITEMS = ["Lair of the Hydra Map", "Fragment of the Hydra"]
PoE_Prices = {}
POE_TRADE_URL = "https://www.pathofexile.com/api/trade/search/Ritual"


def search_item(item, is_map)
  if is_map
    body = {"query":{"status":{"option":"online"},"type":{"option": item,"discriminator":"warfortheatlas"},"stats":[{"type":"and","filters":[],"disabled":false}],"filters":{"trade_filters":{"disabled":true,"filters":{"price":{"min":3}}}}},"sort":{"price":"asc"}}.to_json
  else
    body = {"query":{"status":{"option":"online"},"type": item,"stats":[{"type":"and","filters":[],"disabled":true}],"filters":{"trade_filters":{"filters":{"price":{"min":3}}}}},"sort":{"price":"asc"}}.to_json
  end
  data = RestClient.post POE_TRADE_URL, body, {content_type: :json, accept: :json}
  return JSON.parse(data)
end

def check_prices(ids)
  url = "https://www.pathofexile.com/api/trade/fetch/" + ids['result'].take(10).join(',')
  raw_data = RestClient.get url, {params: {query: ids['id']}}
  data = JSON.parse(raw_data)
  prices = []
  data['result'].each do |x|
    prices << x['listing']['price']['amount']
  end
  return prices
end

POE_ITEMS.each do |item|
  is_map = false
  is_map = true if item.include? "Map"
  ids = search_item(item, is_map)
  prices = check_prices(ids)
  PoE_Prices[item] = prices.drop(2)  #Ignoring undercutters
  sleep 10 # Ratelimit avoidance, might need to increase
end
