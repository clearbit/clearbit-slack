require 'spec_helper'

describe Clearbit::Slack::Attachments::Person, '#as_json' do
  it 'returns a person attachment' do
    person = Clearbit::Person.new(person_data)

    result = Clearbit::Slack::Attachments::Person.new(person).as_json

    expect(result).to eq({
      :text=>"O'Reilly author, software engineer & traveller. Founder of https://clearbit.com",
      :color=>"good",
      :fields=>[
        {:title=>"Email", :value=>"alex@alexmaccaw.com", :short=>true},
        {:title=>"Employment", :value=>"Clearbit", :short=>true},
        {:title=>"Position", :value=>"CEO", :short=>true},
        {:title=>"Location", :value=>"San Francisco, CA, USA", :short=>true},
        {:title=>"AboutMe", :value=>"<https://about.me/maccaw|maccaw>", :short=>true},
        {:title=>"AngelList", :value=>"<https://angel.co/maccaw|maccaw> (532 followers)", :short=>true},
        {:title=>"Facebook", :value=>"<https://www.facebook.com/amaccaw|amaccaw>", :short=>true},
        {:title=>"LinkedIn", :value=>"<https://www.linkedin.com/pub/alex-maccaw/78/929/ab5|pub/alex-maccaw/78/929/ab5>", :short=>true},
        {:title=>"Twitter", :value=>"<http://twitter.com/maccaw|@maccaw> (15,248 followers)", :short=>true}
      ]
    })
  end

  def person_data
    parsed_fixture_data('person.json')
  end
end
