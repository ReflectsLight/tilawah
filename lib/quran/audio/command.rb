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

    def method_missing(m, *ary, &b)
      Ryo.property?(options, m) ? options[m] : super
    end

    def respond_to_missing?(m, p = false)
      Ryo.property?(options, m) || super
    end

    private

    def line
      @line ||= IO::Line.new($stdout)
    end

    def options
      @options ||= parse_options(argv)
    end
  end
end
