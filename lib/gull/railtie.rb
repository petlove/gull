# frozen_string_literal: true

require 'gull'
require 'rails'

module Gull
  # Gull Railtie: wraps the gem into the actual rails application
  class Railtie < Rails::Railtie
    railtie_name :gull
    rake_tasks do
      Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each { |f| load f }
    end
  end
end
