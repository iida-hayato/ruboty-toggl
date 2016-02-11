require 'toggl'
module Ruboty
  module Toggl
    module Actions
      class Start < Base
        def call
          if access_token?
            start
          else
            require_access_token
          end
        end

        private

        def start
          message.reply("Created #{time_entity}")
        rescue => exception
          message.reply("Failed by #{exception.class}")
        end

        def time_entity
          toggl = Toggl.new(access_token)
          toggl.create_time_entry()
        end

      end
    end
  end
end
