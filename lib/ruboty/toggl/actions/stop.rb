module Ruboty
  module Toggl
    module Actions
      class Stop < Base
        def call
          if access_token?
            stop
            report
          else
            require_access_token
          end
        end

        private

        def stop
          toggl.stop_time_entry current_time_entry["id"]
          # rescue => exception
          #   message.reply("Failed by #{exception.class}")
        end

        def report
          project = toggl.get_project(current_time_entry['pid'])['name']
          message.reply("Stop `#{current_time_entry['description']}` in project `#{project['name']}` !")

        end

      end
    end
  end
end