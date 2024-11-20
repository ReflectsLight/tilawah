# frozen_string_literal: true

module Quran::Audio
  ##
  # The {Quran::Audio::Command Quran::Audio::Command} class
  # is the superclass of all commands.
  class Command
    require_relative "command/ls"
    require_relative "command/pull"
    include FileUtils

    ##
    # @return [Ryo]
    #  Command-line options
    attr_reader :options

    ##
    # @param [Ryo] options
    def initialize(options)
      @options = options
    end

    private

    def dir
      @dir ||= Ryo.from({
        localbase: File.join(Dir.home, ".local"),
        share: Ryo.memo { File.join(localbase, "share", "quran-audio") },
        root: File.realpath(File.join(__dir__, "..", "..", "..")),
        erb: Ryo.memo { File.join(root, "share", "quran-audio", "erb") },
        json: Ryo.memo { File.join(root, "share", "quran-audio", "json") },
      })
    end

    def line
      @line ||= IO::Line.new($stdout)
    end
  end
end
