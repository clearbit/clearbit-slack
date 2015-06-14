require 'clearbit'
require 'slack-notifier'

require 'clearbit/slack/configuration'
require 'clearbit/slack/helpers'
require 'clearbit/slack/version'
require 'clearbit/slack/attachments/person'
require 'clearbit/slack/attachments/company'

module Clearbit
  module Slack
    def self.lookup(email)
      # TODO: https://github.com/clearbit/clearbit-slack/issues/4
    end

    def self.notify(person, company)
      name = person.name.full_name || [person.name.given_name, person.name.family_name].join(' ')
      notifier = ::Slack::Notifier.new(
        slack_url,
        channel: slack_channel,
        username: name,
        icon_url: person.avatar
      )
      # TODO: https://github.com/clearbit/clearbit-slack/issues/5
      crm_link = ''
      notifier.ping crm_link, attachments: [
        Attachments::Person.new(person).as_json,
        Attachments::Company.new(company).as_json
      ]
    end

    def self.slack_url
      configuration.slack_url || raise('Config Error: No slack_url provided')
    end

    def self.slack_channel
      configuration.slack_channel || raise('Config Error: No slack_channel provided')
    end

    def self.configure
      yield configuration if block_given?
    end

    def self.configuration
      @configuration ||= Configuration.new
    end
  end
end
