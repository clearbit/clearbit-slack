module Clearbit
  module Slack
    class Notifier
      attr_reader :company, :message, :person, :given_name, :family_name, :email
      attr_reader :slack_url, :slack_channel

      def initialize(attrs = {})
        @company       = attrs[:company]
        @message       = attrs[:message]
        @person        = attrs[:person]
        @given_name    = attrs[:given_name]
        @family_name   = attrs[:family_name]
        @email         = attrs[:email]
        @slack_url     = attrs[:slack_url] || Slack.slack_url
        @slack_channel = attrs[:slack_channel] || Slack.slack_channel
      end

      def ping
        notifier = ::Slack::Notifier.new(
          slack_url,
          channel:  slack_channel,
          icon_url: icon_url,
          username: username
        )

        attachments << Attachments::Person.new(person).as_json

        if company
          attachments << Attachments::Company.new(company).as_json
        end

        notifier.ping message.to_s, attachments: attachments
      end

      private

      def icon_url
        person && person.avatar || ''
      end

      def username
        if person.name.full_name
          person.name.full_name
        elsif person.name.given_name && person.name.family_name
          [person.name.given_name, person.name.family_name].join(' ')
        else
          'Unknown'
        end
      end

      def person
        @person ||= unknown_person
      end

      def unknown_person
        Mash.new(
          email: email,
          name: {
            given_name: given_name,
            family_name: family_name
          }
        )
      end

      def attachments
        @attachments ||= []
      end
    end
  end
end
