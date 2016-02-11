module Ruboty
  module Toggl
    module Actions
      class Workspaces < Base
        def call
          if access_token?
            get_workspaces
          else
            require_access_token
          end
        rescue => exception
          message.reply("Failed by #{exception.class}")
        end


        private
        def get_workspaces
          message.reply("select your workspace.\n #{toggl.my_workspaces.map { |h| "`workspace #{h['id']}`    #{h['name']}" }.join("\n")} ")
        end
      end
    end
  end
end
