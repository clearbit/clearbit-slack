require 'clearbit'
require 'slack-notifier'

require 'clearbit/slack/configuration'
require 'clearbit/slack/helpers'
require 'clearbit/slack/notification'
require 'clearbit/slack/streaming'
require 'clearbit/slack/version'
require 'clearbit/slack/attachments/person'
require 'clearbit/slack/attachments/company'

module Clearbit
  module Slack
    def self.slack_url
      configuration.slack_url || raise('Config Error: No slack_url provided')
    end

    def self.slack_channel
      configuration.slack_channel || raise('Config Error: No slack_channel provided')
    end

    def self.default_avatar
      configuration.default_avatar || ''
    end

    def self.default_username
      configuration.default_username || 'Unknown'
    end

    def self.configure
      yield configuration if block_given?
    end

    def self.configuration
      @configuration ||= Configuration.new
    end
  end
end
