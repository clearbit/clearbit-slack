require 'spec_helper'

describe Clearbit::Slack::Notifier do

  let(:params) do
    {
      person: nil,
      full_name: 'Alex Maccaw',
      email: 'alex@alexmaccaw.com',
      message: 'message'
    }
  end

  context 'default values for given_name and family_name' do
    let(:notifier) { double(ping: true) }

    before do
      allow(Slack::Notifier).to receive(:new).and_return(notifier)
    end

    it 'returns the default values' do
      Clearbit::Slack::Notifier.new(params).ping

      expect(Slack::Notifier).to have_received(:new).with('http://example') { |&block|
        expect(block).to be(
          default(
            channel: '#test',
            icon_url: nil
          )
        )
      }

      expect(notifier).to have_received(:ping).with('message', attachments: [{
        :fallback=>'alex@alexmaccaw.com - Alex Maccaw',
        :author_name=>'Alex Maccaw',
        :author_icon=>nil,
        :text=>'unknown person',
        :color=>"good",
        fields: [{
          title: 'Email',
          value: 'alex@alexmaccaw.com - Alex Maccaw',
          short: true
        }]
      }])
    end
  end

  context 'integration test' do
    it 'the default values are able to be post to slack' do
      stub = stub_request(:post, 'example')

      Clearbit::Slack::Notifier.new(params).ping

      expect(stub).to have_been_requested
    end
  end
end
