require 'gcm_middleware'
require 'faraday_middleware'
require 'json'

module GCMFaraday
  class Sender
    URL = 'https://android.googleapis.com'.freeze
    PATH = '/gcm/send'.freeze

    def initialize(*adapters)
      default_adapters = adapters || [Faraday.default_adapter]
      @conn = Faraday.new(URL) do |builder|
        builder.request :json
        builder.request :gcm_authentication, key: api_key

        builder.response :json
        builder.use :gcm_canonical_id
        builder.adapter *default_adapters
      end
    end

    def post(data, *ids)
      response = conn.post(PATH, body(data, ids))
      ::Response.new(response)
    end

    private

    attr_reader :conn

    def api_key
      ::GCMFaraday.configuration.api_key
    end

    def body(data, ids)
      {
        registration_ids: ids,
      }.merge(data: data.to_h).to_json
    end
  end
end
