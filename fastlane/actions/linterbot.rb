module Fastlane
  module Actions

    class LinterbotAction < Action
      def self.run(params)
        repo_slug = ENV["TRAVIS_REPO_SLUG"]
        pull_request = ENV["TRAVIS_PULL_REQUEST"]
        verbose = params[:verbose]
        if verbose
          UI.message "REPO_SLUG: #{repo_slug}"
          UI.message "PR_NUMBER: #{pull_request}"
        end
        if pull_request.to_s.length == 0
          UI.message "Not in a Pull Request, skip report"
        else
          sh "bundle exec linterbot #{repo_slug} #{pull_request} < swiftlint-report.json"
        end
      end

      def self.description
        "A short description with <= 80 characters of what this action does"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "You can use this action to do cool things..."
      end

      def self.available_options
        [FastlaneCore::ConfigItem.new(key: :verbose,
                                       env_name: "FL_LINTERBOT_VERBOSE",
                                       description: "Show more detail",
                                       is_string: false,
                                       default_value: true)]
      end

      def self.output
        []
      end

      def self.return_value
      end

      def self.authors
        ["at-suho"]
      end

      def self.example_code
        ["linterbot(verbose: true)"]
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end
end
