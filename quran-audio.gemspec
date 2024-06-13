# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.name = "quran-audio"
  gem.authors = ["0x1eef"]
  gem.email = ["0x1eef@protonmail.com"]
  gem.homepage = "https://github.com/ReflectsLight/quran-audio#readme"
  gem.version = File.binread("./share/quran-audio/VERSION")[/[\d.]+/]
  gem.licenses = ["BSD0L"]
  gem.files = Dir[
    "README.md",
    "LICENSE",
    "libexec/**/*",
    "lib/**/*.rb",
    "share/**/*",
    "bin/*"
  ]
  gem.executables = ["quran-audio"]
  gem.require_paths = ["lib"]
  gem.summary = "Downloads recitations of The Noble Quran from everyayah.com"
  gem.description = gem.summary
  gem.add_runtime_dependency "ryo.rb", "~> 0.5"
  gem.add_runtime_dependency "cmd.rb", "~> 0.5"
  gem.add_runtime_dependency "paint", "~> 2.3"
  gem.add_runtime_dependency "json", "~> 2.6"
  gem.add_runtime_dependency "io-line.rb", "~> 0.1"
  gem.add_development_dependency "standard", "~> 1.25"
end
