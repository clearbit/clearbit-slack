module Clearbit
  module Slack
    class Configuration
      attr_accessor :slack_url, :slack_channel, :default_avatar, :default_username

      def clearbit_key=(value)
        Clearbit.key = value
      end
    end
  end
end
