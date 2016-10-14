require 'spec_helper'

describe Clearbit::Slack::Attachments::Company, '#as_json' do
  it 'returns a company attachment' do
    company_data = parsed_fixture_data 'company.json'
    company = Mash.new(company_data)

    result = Clearbit::Slack::Attachments::Company.new(company).as_json

    expect(result).to include(
      {
        :author_name => "Clearbit",
        :author_icon => "https://logo.clearbit.com/clearbit.com",
        :text => "Clearbit provides powerful products and data APIs to help your business grow. Contact enrichment, lead generation, financial compliance, and more...",
        :color => "good",
        :fields => [
          {
            :title => "Location",
            :value => "3030 16th St, San Francisco, CA 94103, USA",
            :short => false
          },
          {
            :title => "Website",
            :value => "http://clearbit.com",
            :short => true
          },
          {
            :title => "Type",
            :value => "private",
            :short => true
          },
          {
            :title => "Raised",
            :value => "$250,000",
            :short => true
          },
          {
            :title => "Employees",
            :value => "10",
            :short => true
          },
          {
            :title => "LinkedIn",
            :value => "<https://www.linkedin.com/company/clearbit|company/clearbit>",
            :short => true
          },
          {
            :title => "Twitter",
            :value => "<http://twitter.com/clearbit|clearbit> (616 followers)",
            :short => true
          },
          {
            :title => "Tags",
            :value => "Technology, Information Technology & Services",
            :short => false
          },
          {
            :title => "Tech",
            :value => "google_analytics, kiss_metrics, mixpanel, adroll, olark, typekit_by_adobe, perfect_audience, customer_io, intercom, google_apps, mailgun, mixpanel, aws_route_53, aws_ec2",
            :short => false
          }
        ]
      }
    )
  end
end
