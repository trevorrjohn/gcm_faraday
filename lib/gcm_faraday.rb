require 'gcm_faraday/version'
require 'gcm_faraday/data'
require 'gcm_faraday/configuration'
require 'gcm_faraday/sender'
require 'gcm_faraday/response'

module GCMFaraday
  class << self
    attr_accessor :configuration

    def configure
      @configuration = GCMFaraday::Configuration.new

      yield @configuration
    end
  end

  def initialize
  end
end
