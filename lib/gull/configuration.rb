# frozen_string_literal: true

module Gull
  class Configuration
    attr_accessor :google_client_id, :google_client_secret, :logo_name, :logo_style

    DEFAULT_LOGO = 'default.gif'

    def initialize
      @google_client_id = nil
      @google_client_secret = nil
      @logo_name = DEFAULT_LOGO
      @logo_style = nil
    end

    def after_config!
      @logo_style = 'margin-top:60px;' if @logo_name == DEFAULT_LOGO
      Rails.application.config.assets.precompile += ['peto.png', 'sessions.scss', @logo_name] if defined?(Rails)
    end
  end
end
