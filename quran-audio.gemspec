# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.name = "quran-audio"
  gem.authors = ["0x1eef"]
  gem.email = ["0x1eef@protonmail.com"]
  gem.homepage = "https://github.com/ReflectsLight/quran-audio#readme"
  gem.version = File.binread("./VERSION")[/[\d.]+/]
  gem.licenses = ["BSD0L"]
  gem.files = `git ls-files`.split($/)
  gem.require_paths = ["lib"]
  gem.summary = "quran-audio is command-line utility that " \
                "downloads recitations of The Noble Quran"
  gem.description = gem.summary
  gem.add_runtime_dependency "optparse", "~> 0.3"
  gem.add_runtime_dependency "ryo.rb", "~> 0.5"
  gem.add_runtime_dependency "cmd.rb", "~> 0.1"
  gem.add_runtime_dependency "io-line.rb", "~> 0.1"
  gem.add_runtime_dependency "paint", "~> 2.3"
  gem.add_runtime_dependency "json", "= 2.6.1"
  gem.add_runtime_dependency "io-console", "= 0.5.11"
  gem.add_development_dependency "standard", "~> 1.25"
end
