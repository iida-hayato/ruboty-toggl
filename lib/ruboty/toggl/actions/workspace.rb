module Ruboty
  module Toggl
    module Actions
      class Workspace < Base
        def call
          workspace
          report
        end

        def workspaces
          toggl = TogglV8::API.new(access_token)
          message.reply("select your workspace.\n `workspace #{toggl.my_workspaces.map{|h| h["name"]}.join("\n")}` ")
        end

        private

        def report
          message.reply("Remembered #{sender_name}'s workspace")
        end

        def given_access_token
          message[:workspace]
        end

      end
    end
  end
end
