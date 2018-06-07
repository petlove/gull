# frozen_string_literal: true

require 'gull'
require 'rails'

module Gull
  # Gull Railtie: wraps the gem into the actual rails application
  class Railtie < Rails::Railtie
    railtie_name :gull
    rake_tasks do
      gull_rakedir_path = File.join(File.dirname(__FILE__), 'tasks/*.rake')
      rake_tasks = Dir[gull_rakedir_path]
      rake_tasks.each { |f| load f }
    end
  end
end
