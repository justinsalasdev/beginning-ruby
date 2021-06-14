require_relative 'bot'

bot = Bot.new(name:'Fred',data_file:'bot_data')

puts bot.greet

while input = gets and input.chomp != 'end'
    puts '>> ' + bot.respond(input)
end

puts bot.farewell
