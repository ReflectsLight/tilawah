# frozen_string_literal: true

class ReciterIndex
  require "erb"
  require "paint"
  attr_reader :cmd

  def initialize(cmd)
    @cmd = cmd
  end

  def to_s
    str = render
    max = str.max_by(&:size)
    cols = (width - max.size + 3) / 2
    str.map { (" " * cols) + _1 }.join
  end

  private

  def render
    Ryo.each(cmd.reciters).map do |switch, reciter|
      ERB.new(template).result_with_hash({switch:, reciter:})
    end.join("\n").each_line
  end

  def width
    IO.console.winsize[1]
  end

  def template
    @template ||= File.binread File.join(cmd.share_dir, "erb", "reciter.txt.erb")
  end
end
