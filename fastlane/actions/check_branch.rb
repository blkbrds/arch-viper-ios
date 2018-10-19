module Fastlane
  module Actions
    class CheckBranchAction < Action
      def self.run(params)
        branch = ENV["TRAVIS_PULL_REQUEST_BRANCH"]
        if branch == ""
          branch = ENV["TRAVIS_BRANCH"]
        end
        show_name = params[:show_name]
        if show_name
          UI.message "Branch name: #{branch}"
        end
        if branch == "master"
          return
        end
        prefixs = ["feature", "bugfix", "hotfix", "release"]
        for prefix in prefixs
          if branch.start_with?("#{prefix}/")
            return
          end
        end
        UI.user_error!("Your branch: `#{branch}` does not pass convention")
      end

      def self.description
        "Raises an exception if not on a available git branch"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "This action will check your branch name is pass convention"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :show_name,
                                       env_name: "FL_CHECK_BRANCH_NAME",
                                       description: "Show name of branch",
                                       is_string: false,
                                       default_value: true)
        ]
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
        [
          "check_branch(show_name: true)"
        ]
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end
end
