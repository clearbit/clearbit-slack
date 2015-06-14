lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'clearbit/slack'

Clearbit::Slack.configure do |config|
  config.slack_url = ENV['SLACK_URL']
  config.slack_channel = '#test'
  config.default_avatar = 'https://placekitten.com/g/75/75'
end

Clearbit::Slack::Streaming.lookup(
  email: 'alex@clearbit.com',
  first_name: 'Alex',
  last_name: 'Maccaw',
  message: "View signup in <https://admin.example.com/|Admin Panel>"
)
