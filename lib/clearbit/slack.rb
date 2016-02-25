require 'clearbit'
require 'mash'
require 'slack-notifier'

require 'clearbit/slack/configuration'
require 'clearbit/slack/helpers'
require 'clearbit/slack/notifier'
require 'clearbit/slack/version'
require 'clearbit/slack/attachments/person'
require 'clearbit/slack/attachments/company'

module Clearbit
  module Slack
    def self.ping(attrs = {}, options = {})
      Notifier.new(attrs, options).ping
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
