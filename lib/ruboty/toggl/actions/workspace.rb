module Ruboty
  module Toggl
    module Actions
      class Workspace < Base
        def call
          set_workspace
          report
        end

        def get_workspaces
          toggl = TogglV8::API.new(access_token)
          message.reply("select your workspace.\n #{toggl.my_workspaces.map { |h| "#{h['name']} `workspace #{h['id']}`" }.join("\n")} ")
        end

        private
        def set_workspace
          access_tokens[sender_name] = given_workspace
        end

        def report
          message.reply("Remembered #{sender_name}'s workspace")
        end

        def given_workspace
          message[:workspace]
        end

      end
    end
  end
end
