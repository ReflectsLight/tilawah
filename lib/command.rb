# frozen_string_literal: true

require "cmd"
require "ryo"
require "ryo/json"
require "io/line"

class Command < Cmd
  require_relative "command/mixin/path"
  include Mixin::Path

  private
  def line
    @line ||= IO::Line.new($stdout)
  end
end
