# frozen_string_literal: true

module Quran
  module Audio
    require "cmd"
    require "ryo"
    require "ryo/json"
    require "fileutils"
    require "io/line"
    require "net/http"
    require_relative "audio/command"
    require_relative "audio/mp3"
  end
end
