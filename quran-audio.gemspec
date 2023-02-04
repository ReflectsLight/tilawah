# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.name = "quran-audio"
  gem.authors = ["0x1eef"]
  gem.email = ["0x1eef@protonmail.com"]
  gem.homepage = "https://github.com/ReflectsLight/quran-audio#readme"
  gem.version = "0.1.0"
  gem.licenses = ["BSD0L"]
  gem.files = `git ls-files`.split($/)
  gem.require_paths = ["lib"]
  gem.summary = "quran-audio is a utility for downloading recitations of the holy book: The Quran"
  gem.description = gem.summary
  gem.add_runtime_dependency "ruby-mp3info", "~> 0.8"
  gem.add_runtime_dependency "optparse", "~> 0.5"
  gem.add_runtime_dependency "ryo.rb", "~> 0.3"
  gem.add_runtime_dependency "io-line.rb", "~> 0.1"
  gem.add_runtime_dependency "paint", "~> 2.3"
end
