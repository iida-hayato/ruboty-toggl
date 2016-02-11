module Ruboty
  module Handlers
    class Toggl < Base

      on(
          /token (?<token>.+)\z/,
          name: "remember",
          description: "Remember sender's Toggl access token",
      )



      def remember(message)
        Ruboty::Toggl::Actions::Remember.new(message).call
      end
      
      def start(message)
        Ruboty::Toggl::Actions::Start.new(message).call
      end
    end
  end
end
