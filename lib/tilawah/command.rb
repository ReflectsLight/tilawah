# frozen_string_literal: true

module Tilawah
  ##
  # The {Tilawah::Command Tilawah::Command} class
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

    def line
      @line ||= IO::Line.new($stdout)
    end
  end
end
