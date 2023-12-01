# frozen_string_literal: true

require "cmd"
require "ryo"
require "io/line"

class Command
  require_relative "command/mixin/path"
  include Cmd
  include Mixin::Path

  private
  def line
    @line ||= IO::Line.new($stdout)
  end
end
