# Clearbit Slack

Send Clearbit person and company information into a Slack channel.

![alex_test](https://cloud.githubusercontent.com/assets/739782/8149387/3f89cd68-1276-11e5-863c-5529237bfe6c.png)

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'clearbit-slack'
```

And then execute:

    $ bundle

### Configuration

Set up Slack config vars:

```ruby
Clearbit::Slack.configure do
  slack_channel: '#signups'
  slack_url: ENV['SLACK_URL'],
end
```

### Webhooks

Use the Combined Lookup API with webhooks:

```ruby
class WebhookController < ApplicationController
  def clearbit
    webhook = Clearbit::Webhook.new(env)

    if webhook.body.person.persent?
      Clearbit::Slack.notify(webhook.body.person, webhook.body.company)
    end

    # ...
  end
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/clearbit-slack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
