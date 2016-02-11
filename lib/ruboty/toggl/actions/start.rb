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
          toggl = TogglV8::API.new(nil,access_token)
          params= {
              :billable => false,
              :description => message[:description],
              :project => message[:project],
          }
          toggl.start_time_entry(params)
        end

      end
    end
  end
end
