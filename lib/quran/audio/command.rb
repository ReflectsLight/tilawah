# frozen_string_literal: true

require "cmd"
require "ryo"
require "ryo/json"
require "io/line"

module Quran::Audio
  class Command < Cmd
    require_relative "command/mixin/path"
    require_relative "command/ls"
    require_relative "command/pull"
    include Mixin::Path

    private
    def line
      @line ||= IO::Line.new($stdout)
    end
  end
end
