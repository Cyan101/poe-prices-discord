require 'discordrb'
require 'yaml'
CONFIG = OpenStruct.new YAML.load_file 'settings.yaml'
require_relative 'poe-prices.rb'

bot = Discordrb::Commands::CommandBot.new  token: CONFIG.token, prefix: CONFIG.prefix
puts bot.invite_url

bot.command(:eval, help_available: false) do |event, *code|
  break unless event.user.id == CONFIG.owner
  begin
    eval code.join(' ')
  rescue => e
    "It didn't work :cry: sorry.... ```#{e}```"
  end
end

bot.command(:stop, help_available: false) do |event|
  break unless event.user.id == CONFIG.owner
  break if $poe_embed == nil
  $poe_embed = nil
  'PoE Map/Frag Pricing has stopped'
end


bot.command(:start, help_available: false) do |event|
  break unless event.user.id == CONFIG.owner

  $poe_embed = event.send_message(nil, nil, poe_embed_create(event))

  while $poe_embed
    begin
      run_pc()
    rescue => err
      event.send_message "Bot Stopped: #{err}"
      $poe_embed = nil; break
    else
      $poe_embed.edit(nil, poe_embed_create(event))
      sleep 200
    end
  end

end

def poe_embed_create(event)
  embed = Discordrb::Webhooks::Embed.new
  embed.tap do |e|
    e.author = { name: "Github - poe-prices-discord", url: 'https://github.com/cyan101/poe-prices-discord', icon_url: event.bot.profile.avatar_url }
    e.color = '3498db'
    e.thumbnail = { url: event.bot.profile.avatar_url }
    e.title = 'PoE Map/Fragment Pricing'
    e.description = 'Shaper/Elder Guardian Maps & Fragments - Updated every 10min'
    e.timestamp = Time.now.utc
    #
    PoE_Prices.each_with_index do |(x, y), i|
      x = event.server.emoji.values.find { |z| z.name == x.gsub(' ','') }.mention  + ' ' + x if CONFIG.emoji == true
      e.add_field name: x, value: y[0].to_s + 'c', inline: true
      e.add_field(name: "​​", value: "​", inline: true) if i.odd?
    end
    return embed
  end
end

bot.run
