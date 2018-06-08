# frozen_string_literal: true

require 'gull'
require 'rails'

module Gull
  class Railtie < Rails::Railtie
    railtie_name :gull
    rake_tasks do
      Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each { |f| load f }
    end
  end
end
