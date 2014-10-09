describe GCMFaraday::Sender do
  let(:raw_response) do
    {
      'multicast_id' => '123',
      'success' => 1,
      'failure' => 0,
      'canonical_ids' => 0,
      'results'  => [
        {
          'message_id' => '987',
          'registration_id' => '456',
          'error' => nil
        }
      ]
    }
  end
  let(:adapter) do
    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.post('/gcm/send') { |env| [200, {'Content-Type' => 'application/json'}, raw_response] }
    end
  end
  let(:sender) { GCMFaraday::Sender.new(:test, adapter) }

  before do
    Faraday.default_adapter = adapter

    GCMFaraday.configure do |config|
      config.api_key = 'api-key'
    end
  end

  describe '#post' do
    let(:data) { GCMFaraday::Data.new(message: 'Message') }
    let(:ids) { ['1'] }

    it 'returns a GCMFaraday::Response' do
      response = sender.post(data, *ids)
      expect(response).to be_a GCMFaraday::Response
    end
  end
end
