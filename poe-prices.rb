require 'json';
require 'rest-client'

POE_ITEMS = {"Lair of the Hydra Map" => :shaper_map, "Fragment of the Hydra" => :fragment, "Pit of the Chimera Map" => :shaper_map, "Fragment of the Chimera" => :fragment, "Maze of the Minotaur Map" => :shaper_map, "Fragment of the Minotaur" => :fragment,
  "Forge of the Phoenix Map" => :shaper_map, "Fragment of the Phoenix" => :fragment, "Elder1" => :elder_map,  "Fragment of Enslavement" => :fragment, "Elder2" => :elder_map, "Fragment of Eradication" => :fragment, "Elder3" => :elder_map,
  "Fragment of Constriction" => :fragment, "Elder4" => :elder_map, "Fragment of Purification" => :fragment}
ELDER_NAME_LOOKUP = ["The Enslaver", "The Eradicator", "The Constrictor", "The Purifier"]
PoE_Prices = {"Lair of the Hydra Map" => [1,1,1,1,1]} # Test Map
POE_TRADE_URL = "https://www.pathofexile.com/api/trade/search/Ritual"

def run_pc
  puts 'Starting PC'
  POE_ITEMS.each do |item, type|
    ids = search_item(item, type)
    prices = check_prices(ids)
    x = item[-1].to_i - 1 if type == :elder_map
    item = ELDER_NAME_LOOKUP[x] if type == :elder_map
    PoE_Prices[item] = prices.drop(2) #Ignoring undercutters
    sleep 10 # Ratelimit avoidance, might need to increase
  end
end

def search_item(item, type)
  case type
  when :shaper_map
    body = {"query":{"status":{"option":"online"},"type":{"option": item,"discriminator":"warfortheatlas"},"stats":[{"type":"and","filters":[],"disabled":false}],"filters":{"trade_filters":{"disabled":true,"filters":{"price":{"min":3}}}}},"sort":{"price":"asc"}}.to_json
  when :elder_map
    body = {"query":{"status":{"option":"online"},"stats":[{"type":"and","filters":[{"id":"implicit.stat_3624393862","disabled":false,"value":{"option":item[-1]}}],"disabled":false}],"filters":{"trade_filters":{"filters":{"price":{"min":3}}}}},"sort":{"price":"asc"}}.to_json
  when :fragment
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
