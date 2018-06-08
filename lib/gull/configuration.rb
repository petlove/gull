# frozen_string_literal: true

module Gull
  class Configuration
    attr_accessor :google_client_id, :google_client_secret
    def initialize
      @google_client_id = nil
      @google_client_secret = nil
    end
  end
end
