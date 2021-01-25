require 'discordrb'

bot = Discordrb::Bot.new token: ''

bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end
