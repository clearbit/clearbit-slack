require 'spec_helper'

describe Clearbit::Slack::Attachments::Company, '#as_json' do
  let(:company_data) { parsed_fixture_data 'company.json' }
  let(:company) { Mash.new(company_data) }
  let(:result) { Clearbit::Slack::Attachments::Company.new(company).as_json }

  it 'returns a company attachment' do
    expect(result).to include(
      {
        :author_name => "Clearbit",
        :author_icon => "https://brandbadge.clearbit.com/a114c279-67aa-4faa-beaf-64246a856450",
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

  it 'returns text when the description field is null in the payload' do
    # simluate the description being null in the payload
    company_data["description"] = nil

    # the text value in the payload needs to not be nil
    expect(result).not_to include(
      text: a_nil_value
    )
  end
end
