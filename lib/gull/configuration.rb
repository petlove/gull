# frozen_string_literal: true

module Gull
  # Gull configuration: exposes a configuration block so we use it
  # to configure both google sign in main attributes
  class Configuration
    attr_accessor :google_client_id, :google_client_secret
    def initialize
      @google_client_id = nil
      @google_client_secret = nil
    end
  end
end
