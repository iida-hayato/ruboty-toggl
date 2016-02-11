module Ruboty
  module Toggl
    module Actions
      class Workspace < Base
        def call
          set_workspace
          report
        end

        def get_workspaces
          message.reply("select your workspace.\n #{toggl.my_workspaces.map { |h| "#{h['name']} `workspace #{h['id']}`" }.join("\n")} ")
        end

        private
        def set_workspace
          workspaces[sender_name] = given_workspace
        end

        def report
          message.reply("Remembered #{sender_name}'s workspace")
        end

        def given_workspace
          message[:workspace_id]
        end

      end
    end
  end
end
