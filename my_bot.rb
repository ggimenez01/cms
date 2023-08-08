require 'discordrb'

# Replace 'YOUR_BOT_TOKEN' with the actual token you copied from the Discord Developer Portal
bot_token = 'MTEzNTY0NjUyNzAzODE3NzI4MA.Gzqyfr.ZrYFO_Gk8OaPPxVkqtouyufJVhnlSGv0friLyw'

# Create a new Discord bot instance
bot = Discordrb::Bot.new(token: bot_token)

# Define a command that responds when a user types '!hello' in any channel
bot.message(start_with: '!hello') do |event|
  event.respond("Hello, #{event.user.name}!")
end

# Define a command that sends a random cat image when a user types '!cat' in any channel
bot.message(start_with: '!cat') do |event|
  event.respond('https://cataas.com/cat')
end

# Start the bot and make it listen for commands
bot.run
