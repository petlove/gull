# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gull/version'

Gem::Specification.new do |s|
  s.name          = 'gull'
  s.version       = Gull::VERSION
  s.authors       = ['ripfoghorn']
  s.email         = ['code@petlove.com.br']

  s.summary       = 'Devise and Google Omniauth goodness for Petlove apps'
  s.description   = 'Updates user models, extends rails and pops partials for quick setting up of google sign in'
  s.homepage      = 'https://github.com/petlove/gull'

  s.bindir        = 'exe'
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'devise'
  s.add_dependency 'omniauth-google-oauth2', '~> 1.0'
  s.add_dependency 'omniauth-rails_csrf_protection'
  s.add_dependency 'rails'
  s.add_dependency 'rake'
end
