module Clearbit
  module Slack
    module Streaming
      def self.lookup(options = {})
        message = options[:message] || options[:email]
        response = Clearbit::Streaming::PersonCompany[email: options[:email]]

        notifier_params = options.merge(
          person: response.person,
          company: response.company
        )

        notifier = Slack::Notifier.new(notifier_params)
        notifier.ping(message)

        response
      end
    end
  end
end
