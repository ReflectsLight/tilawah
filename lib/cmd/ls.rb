# frozen_string_literal: true

require_relative "../cmd"
require_relative "mixins/path"
require "json"
require "ryo"
require "erb"
require "io/console"
require "paint"

class Cmd::Ls < Cmd
  set_banner usage: "quran-audio ls [OPTIONS]",
             description: "List recitation authors"
  include Cmd::Path

  def run
    options = parse!(argv)
    options.help ? show_help : run_command(options)
  end

  private

  def run_command(options)
    authors = JSON.parse File.binread(path.authors_file)
    template = File.binread File.join(path.share_dir, "erb", "author.txt.erb")
    render(authors, template) { puts center(_1) }
  end

  def render(authors, template)
    yield authors.map { |switch, author|
      ERB.new(template).result_with_hash({switch:, author: Ryo(author)})
    }.join("\n").each_line
  end

  def center(str)
    maxs = str.max_by(&:size).size
    size = IO.console.winsize[1]
    cols = (size - maxs + 3) / 2
    str.map { (" " * cols) + _1 }.join
  end
end
