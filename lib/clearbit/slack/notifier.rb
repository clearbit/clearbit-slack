module Clearbit
  module Slack
    class Notifier
      attr_reader :company, :message, :person,
                  :full_name, :email,
                  :slack_url, :slack_channel, :slack_icon

      def initialize(attrs = {}, options = {})
        options = Slack.configuration.merge(options)

        @company       = attrs[:company]
        @message       = attrs[:message]
        @person        = attrs[:person]
        @full_name     = attrs[:full_name]
        @email         = attrs[:email]
        @slack_url     = options[:slack_url]
        @slack_channel = options[:slack_channel]
        @slack_icon    = options[:slack_icon]
      end

      def ping
        notifier.ping(message.to_s, attachments: attachments)
      end

      def notifier
        ::Slack::Notifier.new(slack_url) do
          defaults(
            channel: @slack_channel,
            icon_url: @slack_icon
          )
        end
      end

      def attachments
        result = []

        result << Attachments::Person.new(person).as_json

        if company
          result << Attachments::Company.new(company).as_json
        end

        result
      end

      private

      def person
        @person ||= unknown_person
      end

      def unknown_person
        Mash.new(
          email: email,
          bio: 'unknown person',
          name: {
            full_name: full_name,
          }
        )
      end
    end
  end
end
