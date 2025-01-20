module QuranAudio
  def self.setup_bundle!
    bundle = File.realpath File.join(__dir__, "..", "bundle")
    Dir[File.join(bundle, "*")].each { $:.unshift File.join(_1, "lib") }
  end
  setup_bundle!

  require "json"
  require "ryo"
  require "fileutils"
  require "io/console"
  require "io/line"
  require "erb"
  require "paint"
  require "net/http"
  require_relative "quran-audio/command"
  require_relative "quran-audio/mp3"
end
