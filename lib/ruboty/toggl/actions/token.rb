module Ruboty
  module Toggl
    module Actions
      class Token < Base
        def call
          token
          report
        rescue => exception
          message.reply("Failed by #{exception.class}")
        end

        private

        def report
          message.reply("Remembered #{sender_name}'s toggl access token")
        end

        def token
          access_tokens[sender_name] = given_access_token
        end

        def given_access_token
          message[:token]
        end
      end
    end
  end
end
