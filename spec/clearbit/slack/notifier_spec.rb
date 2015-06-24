require 'spec_helper'

describe Clearbit::Slack::Notifier do
  context 'person data not found' do
    it 'returns "Unknown" for username' do
      person = Mash.new(name: {})
      notifier = double(ping: true)
      allow(Slack::Notifier).to receive(:new).and_return(notifier)

      Clearbit::Slack::Notifier.new(person: person).ping

      expect(Slack::Notifier).to have_received(:new).with(
        'http://example', channel: '#test', icon_url: '', username: 'Unknown'
      )
      expect(notifier).to have_received(:ping)
    end
  end
end
