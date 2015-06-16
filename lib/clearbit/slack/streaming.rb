module Clearbit
  module Slack
    module Streaming
      def self.lookup(options = {})
        message = options[:message] || options[:email]
        first_name = options[:first_name]
        last_name = options[:last_name]

        response = Clearbit::Streaming::PersonCompany[email: options[:email]]

        notification = Slack::Notification.new(
          person: response.person,
          company: response.company,
          first_name: first_name,
          last_name: last_name
        )
        notification.ping(message)

        response
      end
    end
  end
end
