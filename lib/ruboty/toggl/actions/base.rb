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

        def workspaces
          message.robot.brain.data[NAMESPACE + WORKSPACE] ||= {}
        end

        def require_workspace
          message.reply("I don't know your default workspace.your can get your workspace list by `workspaces`")
        end

        def workspace?
          !workspace.nil?
        end

        def workspace
          @workspace ||= workspaces[sender_name]
        end

        def project
          @project ||= projects.find{|h| h['name'].start_with? message[:project]}
        end

        def projects
          toggl.projects(workspace)
        end

        def toggl
          @toggl ||= TogglV8::API.new(access_token)
        end

        def current_time_entry
          @current_time_entry ||= toggl.get_current_time_entry
        end

        def reply_my_workspaces
          message.reply("Select your main workspace.\n #{toggl.my_workspaces.map { |h| "`workspace #{h['id']}`    #{h['name']}" }.join("\n")} ")
        end

      end
    end
  end
end
