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

    def dir
      @dir ||= Ryo.from({
        localbase: File.join(Dir.home, ".local"),
        sharedir: Ryo.memo { File.join(localbase, "share", "quran-audio") },
        rootdir: File.realpath(File.join(__dir__, "..", "..", "..")),
        erbdir: Ryo.memo { File.join(rootdir, "share", "quran-audio", "erb") },
        jsondir: Ryo.memo { File.join(rootdir, "share", "quran-audio", "json") },
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
