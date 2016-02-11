module Ruboty
  module Toggl
    module Actions
      class Base
        NAMESPACE = "toggl."
        TOKEN = "access_token"
        WORKSPACE =  "workspace"

        attr_reader :message

        def initialize(message)
          @message = message
        end

        private

        def access_tokens
          message.robot.brain.data[NAMESPACE + TOKEN] ||= {}
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

        def access_token?
          !access_token.nil?
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

        def workspaces
          message.robot.brain.data[NAMESPACE + WORKSPACE] ||= {}
        end

        def require_workspace
          message.reply("I don't know your toggl access token")
        end

        def workspace?
          !workspace.nil?
        end

        def workspace
          @workspace ||= workspaces[sender_name]
        end

        def project
          @project ||= toggl.projects(workspace).find{|h| h['name'].start_with? message[:project]}
        end

        def toggl
          @toggl ||= TogglV8::API.new(access_token)
        end

        def current_time_entry
          @current_time_entry ||= toggl.get_current_time_entry
        end
      end
    end
  end
end
