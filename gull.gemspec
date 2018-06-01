lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gull/version"

Gem::Specification.new do |s|
  s.name          = "gull"
  s.version       = Gull::VERSION
  s.authors       = ["ripfoghorn"]
  s.email         = ["sac@petlove.com.br"]

  s.summary       = "Devise and google omniauth goodness for petlove apps"
  s.description   = "Runs user migrations, update user models, extends rails engine controllers and pops partials you can use for quick setting up of google sign in"
  s.homepage      = "https://github.com/petlove/gull"

  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.16"
  s.add_development_dependency "rake", "~> 10.0"
end
