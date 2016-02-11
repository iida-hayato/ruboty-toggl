module Ruboty
  module Toggl
    module Actions
      class Base
        NAMESPACE = "toggl"

        attr_reader :message

        def initialize(message)
          @message = message
        end

        private

        def access_tokens
          message.robot.brain.data[NAMESPACE] ||= {}
        end

        def body
          message[:description] || ""
        end

        def sender_name
          message.from_name
        end

        def require_access_token
          message.reply("I don't know your toggl access token")
        end

        def has_access_token?
          !!access_token
        end

        def access_token
          @access_token ||= access_tokens[sender_name]
        end

        def client
          Octokit::Client.new(client_options)
        end

        def repository
          message[:repo]
        end

        def client_options
          client_options_with_nil_value.reject { |key, value| value.nil? }
        end

        def client_options_with_nil_value
          {
              access_token: access_token,
          }
        end

      end
    end
  end
end
