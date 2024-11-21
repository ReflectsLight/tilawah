# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.name = "quran-audio"
  gem.authors = ["0x1eef"]
  gem.email = ["0x1eef@protonmail.com"]
  gem.homepage = "https://github.com/ReflectsLight/quran-audio#readme"
  gem.version = File.binread("./share/quran-audio/VERSION")[/[\d.]+/]
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
  gem.executables = ["quran-audio"]
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

  ##
  # development dependencies
  gem.add_development_dependency "standard", "~> 1.25"
  gem.add_development_dependency "irb", "~> 1.14"
end
