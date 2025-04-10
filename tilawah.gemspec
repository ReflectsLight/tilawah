# frozen_string_literal: true

require_relative "lib/tilawah/version"
Gem::Specification.new do |gem|
  gem.name = "tilawah"
  gem.authors = ["0x1eef"]
  gem.email = ["0x1eef@protonmail.com"]
  gem.homepage = "https://github.com/ReflectsLight/tilawah#readme"
  gem.version = Tilawah::VERSION
  gem.licenses = ["GPL-3.0-or-later"]
  gem.files = Dir[
    "README.md",
    "LICENSE",
    "libexec/**/*",
    "lib/**/*.rb",
    "share/**/*",
    "bin/*",
    "bundle/*/lib/*.rb",
    "bundle/*/lib/**/*.rb",
    "bundle/*/lib/*/**/*.rb",
  ]
  gem.executables = ["tilawah"]
  gem.require_paths = ["lib"]
  gem.summary = "Download recitations of The Noble Quran"
  gem.description = gem.summary

  ##
  # runtime dependencies
  # (all but "paint" are from the stdlib)
  gem.add_runtime_dependency "paint", "~> 2.3"
  gem.add_runtime_dependency "json", "~> 2.6"
  gem.add_runtime_dependency "optparse", "~> 0.6"
  gem.add_runtime_dependency "net-http", "~> 0.5"
  gem.add_runtime_dependency "forwardable", "~> 1.3"
  gem.add_runtime_dependency "ryo.rb", "~> 0.5"
  gem.add_runtime_dependency "io-line.rb", "~> 0.1"

  ##
  # development dependencies
  gem.add_development_dependency "standard", "~> 1.25"
  gem.add_development_dependency "irb", "~> 1.14"
end
