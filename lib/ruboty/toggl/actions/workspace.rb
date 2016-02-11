module Ruboty
  module Toggl
    module Actions
      class Workspace < Base
        def call
          if access_token?
            set_workspace
          else
            require_access_token
          end
        rescue => exception
          message.reply("Failed by #{exception.class}")
        end

        private
        def set_workspace
          unless valid_workspace
            message.reply("Invalid workspace id #{given_workspace}")
            return reply_my_workspaces
          end
          workspaces[sender_name] = given_workspace
          message.reply("Remembered #{sender_name}'s workspace")
        end

        def given_workspace
          message[:workspace_id]
        end

        def valid_workspace
          return toggl.projects given_workspace
        rescue => _
          return false
        end
      end
    end
  end
end
