# frozen_string_literal: true

module Cmd
  require "ryo"
  require "io/line"
  require "json"
  require_relative "settings"

  ##
  # @return [String]
  #  Returns the absolute path to the root directory.
  def root_dir
    Settings.get_root_dir.()
  end

  ##
  # @return [String]
  #  Returns the absolute path to the share directory.
  def share_dir
    Settings.get_share_dir.()
  end

  ##
  # @return [String]
  #  Returns the absolute path to the data directory.
  def data_dir
    Settings.get_data_dir.()
  end

  ##
  # @return [Ryo::Object]
  #  Returns a Ryo object that holds all known reciters.
  def reciters
    Settings.get_reciters.()
  end

  ##
  # @return [Ryo::Object<{surah => count}>]
  #  Returns a Ryo object that maps a surah number to its ayah count.
  def count
    @count ||= Ryo.from(
      JSON.parse(File.binread(File.join(data_dir, "count.json")))
    )
  end

  ##
  # @return [IO::Line]
  def line
    @line ||= IO::Line.new($stdout)
  end
end
