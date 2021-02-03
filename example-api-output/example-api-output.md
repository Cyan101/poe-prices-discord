# Example Output from the PoE-Trade API

## Could be used for testing without spamming the API/having tons of waits


### Example Output from Searching for a Item
URL:  https://www.pathofexile.com/api/trade/search/Ritual
Fragment Item - Body: {"query":{"status":{"option":"online"},"type":"Fragment of Eradication","stats":[{"type":"and","filters":[]}]},"sort":{"price":"asc"}}
Map Item - Body: {"query":{"status":{"option":"online"},"type":{"option": "Lair of the Hydra","discriminator":"warfortheatlas"},"stats":[{"type":"and","filters":[],"disabled":false}],"filters":{"trade_filters":{"disabled":true,"filters":{"price":{"min":3}}}}},"sort":{"price":"asc"}}
Elder Map Item - Body: {"query":{"status":{"option":"online"},"stats":[{"type":"and","filters":[{"id":"implicit.stat_3624393862","disabled":false,"value":{"option":"Elder1"}}],"disabled":false}],"filters":{"trade_filters":{"filters":{"price":{"min":3}}}}},"sort":{"price":"asc"}}

Output: item-search.json



### Example Output from Requesting Prices/Info from Stash Tabs
URL: https://www.pathofexile.com/api/trade/fetch/2ec22ce08e12ab0729307df4e417a42e9429632b337dfb0a5e21397a277e26a8,c459e4a799935f673aa71efafe27accb8645d3b496f2b8507d51d515f52ad215,d4e6ced307103d75ae0a3c8fbc3be93f9baed12957c7d88687e2130d7400fa95,0c650a67d8f44f12f0f54f489cc701b2e1f8d2339b270e5877454c6d7f91e169,5ef43e11899b12b70e596a4b7b6217f587d3d510308c9454a54dad6eda9a2b5b,aecf2be45bb00b46bc224f37a46ad2b481a67ac927efc21914ac6ad7bb97be09,f370b3e1e7a575d8eb89fc49e68db6d379680b2b4107b4c6e4ba3706084c9b07,4e9b1bdcf1142e464afe2cd6dc58d53eadf4f927482abd7d53d057ea333cacd9,43f1af970fd1248ad9d3f644a0fa9e50f79dd350bcf132f94ca45d44c045c444,2ed27486746irbb7076d2fe34b7ad1e97a2594ab4c614b7a21f6a5ac9ab168ccc9a?query=aLbevgkfe

Output: price-fetch.json
