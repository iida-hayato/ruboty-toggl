module Ruboty
  module Toggl
    module Actions
      class Workspaces < Base
        def call
          if access_token?
            reply_my_workspaces
          else
            require_access_token
          end
        rescue => exception
          message.reply("Failed by #{exception.class}")
        end


      end
    end
  end
end
