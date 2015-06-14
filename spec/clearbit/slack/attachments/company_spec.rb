require 'spec_helper'

describe Clearbit::Slack::Attachments::Company, '#as_json' do
  it 'returns a company attachment' do
    company = Clearbit::Company.new(company_data)

    result = Clearbit::Slack::Attachments::Company.new(company).as_json

    expect(result).to eq({
      :author_name=>"Clearbit",
      :author_icon=>"https://dqus23xyrtg1i.cloudfront.net/v1/logos/81be4a63-4c59-4fcd-82bd-3a5d8982d3ea",
      :text=>"We are building a suite of business intelligence APIs to help companies find more information on their customers in order to increase sales and reduce fraud. Our goal is to be the data backbone for modern businesses, powering everything from credit checks to lead scoring.\n\nWe currently provide three APIs:\n\n- Person API: Takes an email address and returns information about a person such as name, avatar, title, and social accounts.\n- Company API: Takes a domain name and returns data about a company, such as name, logo, market category, and headcount.\n- Watchlist API: Lets you search names against a consolidate global watchlist, simplifying OFAC compliance.\n\nOur customers mainly use our APIs for lead-scoring, processing all their incoming leads through both the Person and Company APIs to determine which ones are valuable. This saves sales teams a great deal of time compared to manual lead research and qualification. ",
      :color=>"good",
      :fields=>[
        {:title=>"Website", :value=>"http://clearbit.com", :short=>true},
        {:title=>"Location", :value=>"601 4th Street #310, San Francisco, CA 94107, USA", :short=>true},
        {:title=>"Type", :value=>"private", :short=>true},
        {:title=>"Employees", :value=>"10", :short=>true},
        {:title=>"AngelList", :value=>"<https://angel.co/clearbit|clearbit> (184 followers)", :short=>true},
        {:title=>"LinkedIn", :value=>"<https://www.linkedin.com/company/clearbit|company/clearbit>", :short=>true},
        {:title=>"Twitter", :value=>"<http://twitter.com/clearbit|@clearbit> (271 followers)", :short=>true}
      ]
    })
  end

  def company_data
    parsed_fixture_data('company.json')
  end
end
