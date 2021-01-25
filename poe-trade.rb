require 'json';
require 'rest-client'

POE_DATA = {"Lair of the Hydra Map" => 1, "Fragment of the Hydra" => 2}
POE_TRADE_URL = "https://www.pathofexile.com/api/trade/search/Ritual"


def search_item(item, is_map)
  if is_map == true
    body = {"query":{"status":{"option":"online"},"type":{"option": item,"discriminator":"warfortheatlas"},"stats":[{"type":"and","filters":[],"disabled":false}],"filters":{"trade_filters":{"disabled":true,"filters":{"price":{"min":3}}}}},"sort":{"price":"asc"}}.to_json
  else
    body = {"query":{"status":{"option":"online"},"type": item,"stats":[{"type":"and","filters":[],"disabled":true}],"filters":{"trade_filters":{"filters":{"price":{"min":3}}}}},"sort":{"price":"asc"}}.to_json
  end
  data = RestClient.post POE_TRADE_URL, body, {content_type: :json, accept: :json}
  return JSON.parse(data)
end

def check_prices(ids)
  url = "https://www.pathofexile.com/api/trade/fetch/" + ids['result'][0...10].join(',')
  data = RestClient.get url, {params: {query: ids['id']}}
  puts data
  return false
end

POE_DATA.each do |item, y|
  is_map = false
  is_map = true if item.include? "Map"
  ids = search_item(item, is_map)
  check_prices(ids)
end
