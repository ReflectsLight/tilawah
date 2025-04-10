# frozen_string_literal: true

module Tilawah
  require "json"
  require "ryo"
  require "fileutils"
  require "io/console"
  require "io/line"
  require "erb"
  require "paint"
  require "net/http"

  require_relative "tilawah/version"
  require_relative "tilawah/command"
  require_relative "tilawah/mp3"

  ##
  # @return [Ryo::Object]
  #  Returns available recitations
  def self.recitations
    @recitations ||= Ryo.from_json(path: "#{paths.json}/recitations.json")
  end

  ##
  # @return [Ryo::Object]
  #  Returns surah id => ayah count
  def self.sizes
    @sizes ||= Ryo.from_json(path: "#{paths.json}/sizes.json")
  end

  ##
  # @return [Ryo::Object]
  #  Returns available paths
  def self.paths
    @paths ||= Ryo.from({
      localbase: File.join(Dir.home, ".local"),
      share: Ryo.memo { File.join(localbase, "share", "tilawah") },
      root: File.realpath(File.join(__dir__, "..")),
      erb: Ryo.memo { File.join(root, "share", "tilawah", "erb") },
      json: Ryo.memo { File.join(root, "share", "tilawah", "json") }
    })
  end
end
