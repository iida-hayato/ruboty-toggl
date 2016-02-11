module Ruboty
  module Handlers
    class Toggl < Base

      on(
          /token (?<token>.+)\z/,
          name: "token",
          description: "Remember sender's Toggl access token",
      )
      on(
          /workspace (?<workspace_id>.+)\z/,
          name: "workspace",
          description: "Remember sender's Toggle Workspace",
      )

      on(
          /workspaces\z/,
          name: "workspaces",
          description: "Show user's Workspaces",
      )

      on(
          /start (?<description>.+) (?<project>.+)\z/,
          name: "start",
          description: "start toggl",
      )


      def token(message)
        Ruboty::Toggl::Actions::Token.new(message).call
      end

      def workspace(message)
        Ruboty::Toggl::Actions::Workspace.new(message).call
      end

      def workspaces(message)
        Ruboty::Toggl::Actions::Workspace.new(message).get_workspaces
      end

      def start(message)
        Ruboty::Toggl::Actions::Start.new(message).call
      end
    end
  end
end
