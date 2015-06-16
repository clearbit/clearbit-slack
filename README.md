# Clearbit Slack Notifier

Send Clearbit data into a Slack channel.

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
Clearbit::Slack.configure do |config|
  config.slack_url = ENV['SLACK_URL']
  config.slack_channel = '#test'
  config.default_avatar = 'https://placekitten.com/g/75/75'
end
```

### Streaming API

Lookup and notify using the streaming API from a background job:

```ruby
# app/jobs/signup_notification.rb
module APIHub
  module Jobs
    class SignupNotification
      include Sidekiq::Worker

      def perform(customer_id)
        customer = Customer.find!(customer_id)
        response = Clearbit::Slack::Streaming.lookup(
          email:      customer.email,                                           # required
          first_name: customer.first_name,                                      # optional
          last_name:  customer.last_name,                                       # optional
          message:    "View signup in <https://admin.example.com/|Admin Panel>" # optional
        )

        # ...
      end
    end
  end
end
```

_Note:_ The `first_name`, `last_name`, and `message` are optional. However, providing the additional fields will help create more robust Slack notifications if Clearbit data is not found.

### Webhooks

Use the Combined Lookup API with webhooks:

```ruby
class WebhookController < ApplicationController
  def clearbit
    webhook = Clearbit::Webhook.new(env)

    if webhook.body.person || webhook.body.company
      options = {
        message: "View signup in <https://admin.example.com/#{webhook.webhook_id}|Admin Panel>"
      }

      Clearbit::Slack.notify(webhook.body.person, webhook.body.company, options)
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
