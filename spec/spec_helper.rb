$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'webmock/rspec'
require 'clearbit/slack'
require 'pry'

Dir[File.expand_path('spec/support/**/*.rb')].each { |file| require file }

Clearbit::Slack.configure do |config|
  config.slack_url = 'http://example'
  config.slack_channel = '#test'
end

RSpec.configure do |config|
  include Spec::Support::Helpers

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = 'random'
end
