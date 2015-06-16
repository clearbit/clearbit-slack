# Clearbit Slack Notifier

Send Clearbit data into a Slack channel:

![alex_test](https://cloud.githubusercontent.com/assets/739782/8149387/3f89cd68-1276-11e5-863c-5529237bfe6c.png)

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'clearbit-slack'
```

And then execute:

    $ bundle

### Configuration

Add Clearbit and Slack config vars:

```ruby
# config/initializers/clearbit.rb
Clearbit::Slack.configure do |config|
  config.slack_url = ENV['SLACK_URL']
  config.slack_channel = '#test'
  config.default_icon_url = 'https://placekitten.com/g/75/75'
  config.clearbit_key = ENV['CLEARBIT_KEY']
end
```

The `default_icon_url` will be used when no avatar is found for the person:

![screen shot 2015-06-15 at 7 34 48 pm](https://cloud.githubusercontent.com/assets/739782/8174770/ba4ad806-1395-11e5-9298-6f7479f1cdfb.png)

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
        response = Clearbit::Slack.lookup(
          email:      customer.email,
          given_name: customer.first_name,
          family_name:  customer.last_name,
          message:    "View signup in <https://admin-panel.com/#{customer.token}|Admin Panel>"
        )

        # ...
      end
    end
  end
end
```

_Note:_ The `first_name`, `last_name`, and `message` are optional. However, providing the additional fields will help create more robust Slack notifications if Clearbit data is not found.

### Webhooks

Use the notifier directly when processing webhooks with a Clearbit response:

```ruby
# app/controllers/webhooks_controller.rb
class WebhooksController < ApplicationController
  def clearbit
    webhook = Clearbit::Webhook.new(env)

    if webhook.body.person || webhook.body.company
      notifier = Clearbit::Slack::Notifier.new(
        person: webhook.body.person,
        company: webhook.body.company
      )

      notifier.ping("View signup in <https://admin-panel/#{webhook.webhook_id}|Admin Panel>")
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
