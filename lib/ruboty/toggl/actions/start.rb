module Ruboty
  module Toggl
    module Actions
      class Start < Base
        def call
          unless workspace?
            return require_workspace
          end
          if access_token?
            start
          else
            require_access_token
          end
        rescue => exception
          message.reply("Failed by #{exception.class}")
        end

        private

        def start
          message.reply("Start `#{time_entity['description']}` in project `#{project['name']}` !")
        end

        def time_entity
          params= {
              'billable' => false,
              'description' => message[:description],
              'pid' => project['id'],
              'wid' => workspace,
          }
          toggl.start_time_entry(params)
        end

      end
    end
  end
end
