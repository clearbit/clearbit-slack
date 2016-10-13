require 'bundler/gem_tasks'
require 'clearbit'
require 'clearbit/slack'

desc 'Test a live lookup and ping'
task :ping do
  Clearbit.key = ENV['CLEARBIT_KEY']

  Clearbit::Slack.configure do |config|
    config.slack_url = ENV['SLACK_URL']
    config.slack_channel = ENV['SLACK_CHANNEL']
  end

  result = Clearbit::Enrichment.find(email: 'harlow@clearbit.com', given_name: 'Harlow', family_name: 'Ward', stream: true)
  result.merge!(
    email: 'harlow@clearbit.com',
    full_name: 'Harlow Ward',
    message: "View details in <https://admin-panel.com/user_id|Admin Panel>",
  )

  Clearbit::Slack.ping(result)
end
