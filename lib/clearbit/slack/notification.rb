module Clearbit
  module Slack
    class Notification
      attr_reader :person, :company, :first_name, :last_name

      def initialize(attrs = {})
        @company = attrs[:company]
        @first_name = attrs[:first_name]
        @last_name = attrs[:last_name]
        @person = attrs[:person]
      end

      def ping(message)
        notifier = ::Slack::Notifier.new(
          Slack.slack_url,
          channel: Slack.slack_channel,
          icon_url: icon_url,
          username: username
        )

        if person
          attachments << Attachments::Person.new(person).as_json
        end

        if company
          attachments << Attachments::Company.new(company).as_json
        end

        notifier.ping message, attachments: attachments
      end

      private

      def icon_url
        person && person.avatar || Slack.default_icon_url
      end

      def username
        if person
          if person.name.full_name
            person.name.full_name
          elsif person.name.given_name && person.name.family_name
            [person.name.given_name, person.name.family_name].join(' ')
          end
        elsif first_name || last_name
          [first_name, last_name].join(' ')
        else
          'Unknown'
        end
      end

      def attachments
        @attachments ||= []
      end
    end
  end
end
