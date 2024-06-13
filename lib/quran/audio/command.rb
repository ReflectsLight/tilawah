# frozen_string_literal: true

module Quran::Audio
  ##
  # The {Quran::Audio::Command Quran::Audio::Command} class
  # is the superclass of all commands.
  class Command < Cmd
    require_relative "command/ls"
    require_relative "command/pull"
    include FileUtils

    def method_missing(m, *ary, &b)
      Ryo.property?(options, m) ? options[m] : super
    end

    def respond_to_missing?(m, p = false)
      Ryo.property?(options, m) || super
    end

    def respond_to?(m, p = false)
      Ryo.property?(options, m) || super
    end

    private

    def path
      @path ||= Ryo.from({
        rootdir: Ryo.memo { ENV["XDG_DATA_HOME"] || File.join(Dir.home, ".local", "share") },
        sharedir: Ryo.memo { File.join(rootdir, "quran-audio") },
        datadir: Ryo.memo { File.realpath File.join(__dir__, "..", "..", "..", "share", "quran-audio", "data") },
        authors: Ryo.memo { File.join(datadir, "authors.json") },
        length: Ryo.memo { File.join(datadir, "surah_length.json") }
      })
    end

    def options
      @options ||= parse_options(argv)
    end

    def line
      @line ||= IO::Line.new($stdout)
    end
  end
end
