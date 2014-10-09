describe GCMFaraday do
  describe '.configuration' do
    before do
      GCMFaraday.configure do |c|
        c.api_key = 'api_key'
      end
    end

    it 'lets you set the api key' do
      data = GCMFaraday::Data.new(msg: 'message')

      response = data.push('reg_id')

      expect(response.success).to be_true
    end
  end

  describe '#push' do
    # let(:gcm) { GCMFaraday.new('myauthtoken') }

    it 'sends a api request' do
      response = gcm.push(data, 'reg-id')

      expect(response.canonical_ids).to be_empty
      expect(response.errors).to be_empty
    end
  end
end
