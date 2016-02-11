module Ruboty
  module Toggl
    module Actions
      class Token < Base
        def call
          token
        rescue => exception
          message.reply("Failed by #{exception.class}")
        end

        private

        def token
          unless valid_access_token
            return message.reply("invalid access token. https://toggl.com/app/profile")
          end
          access_tokens[sender_name] = given_access_token
          message.reply("Remembered #{sender_name}'s toggl access token")
          reply_my_workspaces
        end

        def given_access_token
          message[:token]
        end

        def valid_access_token
          return TogglV8::API.new(given_access_token).workspaces
        rescue => _
          return false
        end
      end
    end
  end
end
