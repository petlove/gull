require "gull/version"
require 'gull/engine'
require 'gull/configuration'

module Gull
  require 'gull/railtie' if defined?(Rails)

  # To be extended by the User model...
  def from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      # Fix for raccoon's custom validation...
      user.is_active = true if user.has_attribute?(:is_active)    
    end
  end

  # Telling this instance variable is at the module scope
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end  
end
