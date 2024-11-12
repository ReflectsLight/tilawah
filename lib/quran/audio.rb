# frozen_string_literal: true

module Quran
  module Audio
    def self.setup_bundle!
      bundle = File.realpath File.join(__dir__, "..", "..", "bundle")
      Dir[File.join(bundle, "*")].each { $:.unshift File.join(_1, "lib") }
    end
    setup_bundle!

    require "json"
    require "cmd"
    require "ryo"
    require "ryo/json"
    require "fileutils"
    require "io/console"
    require "io/line"
    require "erb"
    require "paint"
    require "net/http"
    require_relative "audio/command"
    require_relative "audio/mp3"
  end
end
