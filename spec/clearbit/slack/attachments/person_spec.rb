require 'spec_helper'

describe Clearbit::Slack::Attachments::Person, '#as_json' do
  it 'returns a person attachment' do
    person_data = parsed_fixture_data 'person.json'
    person = Mash.new(person_data)

    result = Clearbit::Slack::Attachments::Person.new(person).as_json

    expect(result).to eq({
      :fallback => "alex@alexmaccaw.com",
      :color=>"good",
      :author_icon => "https://d1ts43dypk8bqh.cloudfront.net/v1/avatars/d54c54ad-40be-4305-8a34-0ab44710b90d",
      :author_name => nil,
      :text => "O'Reilly author, software engineer & traveller. Founder of https://clearbit.com",
      :fields=>[
        {:title=>"Email", :value=>"alex@alexmaccaw.com", :short=>true},
        {:title=>"Location", :value=>"San Francisco, CA, USA", :short=>true},
        {:title=>"Employment", :value=>"Clearbit", :short=>true},
        {:title=>"Title", :value=>"CEO", :short=>true},
        {:title=>"LinkedIn", :value=>"<https://www.linkedin.com/pub/alex-maccaw/78/929/ab5|pub/alex-maccaw/78/929/ab5>", :short=>true},
        {:title=>"Twitter", :value=>"<http://twitter.com/maccaw|maccaw> (15,248 followers)", :short=>true}
      ]
      })
  end

  it 'returns text when the bio field is null in the payload' do
    person_data = parsed_fixture_data 'person.json'

    # simluate the bio being null in the payload
    person_data["bio"] = nil

    person = Mash.new(person_data)

    result = Clearbit::Slack::Attachments::Person.new(person).as_json

    # the text value in the payload needs to not be nil
    expect(result).to match(
      text: a_value != nil
    )
  end
end
