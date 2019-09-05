# frozen_string_literal: true

module Gull
  class Configuration
    attr_accessor :google_client_id, :google_client_secret, :logo_name, :logo_style

    DEFAULT_LOGO = 'default.gif'

    def initialize
      build_google_client_id!
      build_google_client_secret!
      @logo_name = DEFAULT_LOGO
      @logo_style = nil
    end

    def after_config!
      @logo_style = 'margin-top:60px;' if @logo_name == DEFAULT_LOGO
      Rails.application.config.assets.precompile += ['peto.png', @logo_name] if defined?(Rails)
    end

    def devise_omniauth_config
      [:google_oauth2, @google_client_id, @google_client_secret, hd: 'petlove.com.br', prompt: 'select_account']
    end

    private

    def build_google_client_id!
      @google_client_id = Rails.application.secrets.google_client_id
    rescue StandardError
      nil
    end

    def build_google_client_secret!
      @google_client_secret = Rails.application.secrets.google_client_secret
    rescue StandardError
      nil
    end
  end
end
