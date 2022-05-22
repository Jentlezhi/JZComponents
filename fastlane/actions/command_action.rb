module Fastlane
  module Actions
    module SharedValues
      COMMAND_ACTION_CUSTOM_VALUE = :COMMAND_ACTION_CUSTOM_VALUE
    end

    class CommandActionAction < Action
      def self.run(params)
        cmd = params[:cmd]
        UI.message "★★★★★ 开始执行： #{cmd} 🚀"
        Actions.sh(cmd)
        # sh "shellcommand ./path"
        # Actions.lane_context[SharedValues::COMMAND_ACTION_CUSTOM_VALUE] = "my_val"
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Command"
      end

      def self.available_options
        # Define all options your action supports.

        # Below a few examples
        [
          FastlaneCore::ConfigItem.new(key: :cmd,
                                       env_name: "FL_COMMAND_ACTION_API_TOKEN", # The name of the environment variable
                                       description: "Cmd for CommandAction", # a short description of this parameter
                                       verify_block: proc do |value|
                                          UI.user_error!("No Cmd for CommandAction given, pass using `cmd: 'cmd'`") unless (value and not value.empty?)
                                          # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                       end),
        ]
      end


      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["Jentle"]
      end

      def self.is_supported?(platform)
        # you can do things like
        #
        #  true
        #
        #  platform == :ios
        #
        #  [:ios, :mac].include?(platform)
        #

        platform == :ios
      end
    end
  end
end
