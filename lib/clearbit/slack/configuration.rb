module Clearbit
  module Slack
    class Configuration
      attr_accessor :slack_url, :slack_channel

      def to_hash
        {
          slack_url: slack_url,
          slack_channel: slack_channel
        }
      end

      def merge(hash)
        to_hash.merge(hash)
      end
    end
  end
end
