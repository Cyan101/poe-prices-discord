require 'discordrb'
require 'yaml'
require_relative 'poe-trade.rb'

CONFIG = OpenStruct.new YAML.load_file 'settings.yaml'

bot = Discordrb::Commands::CommandBot.new  token: CONFIG.token, prefix: CONFIG.prefix
puts bot.invite_url

bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end

bot.command(:test, help_available: false) do |event|
  event.channel.send_embed do |e|
    e.author = { name: event.bot.profile.name, url: 'http://github.com/cyan101/poe-trade-discord', icon_url: event.bot.profile.avatar_url }
    e.color = '3498db'
    e.thumbnail = { url: event.bot.profile.avatar_url }
    e.title = 'PoE Map/Fragment Pricing'
    e.description = 'Information on guardian map and fragment pricing updated every 10min'
    e.add_field name: "1", value: "2", inline: true
    e.add_field name: "​​", value: "​", inline: true
    e.add_field name: "1", value: "2", inline: true
  end
end

bot.command(:start, help_available: false) do |event|
  puts event.user.id
  puts CONFIG.owner
  break unless event.user.id == CONFIG.owner
  running = true

  embed_test = event.channel.send_embed do |e|
    e.author = { name: event.bot.profile.name, url: 'http://github.com/cyan101/poe-trade-discord', icon_url: event.bot.profile.avatar_url }
    e.color = '3498db'
    e.thumbnail = { url: event.bot.profile.avatar_url }
    e.title = 'PoE Map/Fragment Pricing'
    e.description = 'Information on guardian map and fragment pricing updated every 10min'
    #
    Poe_data.each_with_index do |(x, y), i|
      puts i
      puts i % 2 != 0 || i == 0
      e.add_field name: x, value: y, inline: i % 2 != 0 || i == 0
    end
  end

#  while running == true
#    sleep 5
#    embed_post.edit "PoE Data: Test " + rand(1..10).to_s
#  end
end


bot.run
