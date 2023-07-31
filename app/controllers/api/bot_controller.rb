# app/controllers/api/bot_controller.rb
module Api
    class BotController < ApplicationController
      protect_from_forgery with: :null_session
  
      # POST /api/bot/commands
      def process_command
        command = params[:command]
        bot_response = process_bot_command(command)
        render json: { message: bot_response }
      end
  
      private
  
      def process_bot_command(command)
        # Implement your logic to process the bot command here and return the bot response
        case command
        when "!hello"
          "Hi Gloriana!"
        when "!weather"
          "The weather today is sunny."
        when "!help"
          "Available commands: !hello, !weather, !help"
        else
          "Unknown command. Please try again."
        end
      end
    end
  end
  