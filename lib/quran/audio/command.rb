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
        root_dir: Ryo.memo { File.realpath(File.join(__dir__, "..", "..", "..")) },
        share_dir: Ryo.memo { File.join(root_dir, "share", "quran-audio") },
        data_dir: Ryo.memo { File.join(share_dir, "data") },
        authors_file: Ryo.memo { File.join(data_dir, "authors.json") },
        length_file: Ryo.memo { File.join(data_dir, "surah_length.json") }
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
