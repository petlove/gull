# frozen_string_literal: true

require 'gull/version'
require 'gull/engine'
require 'gull/configuration'
require 'omniauth-google-oauth2'
require 'omniauth/rails_csrf_protection'

module Gull
  require 'gull/railtie' if defined?(Rails)

  # To be extended by the User model
  def from_omniauth(auth) # rubocop:disable Metrics/PerceivedComplexity
    user_email = auth&.[]('email') || auth&.[]('info')&.[]('email')
    where(email: user_email).first_or_create do |user|
      # Setting user's first values (unless it already have it populated)
      user.email ||= user_email
      user.password ||= Devise.friendly_token[0, 20]

      # Setting user as active, skipping email confirmation section
      user.is_active = true if user.has_attribute?(:is_active)

      # Setting provider and uid values for google oauth
      user.provider = auth&.[]('provider') if user.has_attribute?(:provider)
      user.uid = auth&.[]('uid') if user.has_attribute?(:uid)
      user.skip_confirmation! if user.respond_to?(:skip_confirmation!)
    end
  end

  # Telling this instance variable is at the module scope
  class << self
    attr_accessor :configuration
  end
  # rubocop:disable Lint/DuplicateMethods
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.start!
    configuration&.after_config!
  end

  def self.configure
    yield(configuration)
    configuration.after_config!
  end
  # rubocop:enable Lint/DuplicateMethods

  def self.devise_omniauth_config
    configuration&.devise_omniauth_config
  end
end
