# frozen_string_literal: true

require "json"
require "ryo"
require "ryo/json"
require "erb"
require "io/console"
require "paint"

class Command::Ls < Command
  set_banner usage: "quran-audio ls [OPTIONS]",
             description: "List recitation authors."

  def run
    authors = Ryo.from_json_file(path.authors_file)
    template = File.binread File.join(path.share_dir, "erb", "author.txt.erb")
    render(authors, template)
  end

  private

  def render(authors, template)
    puts Ryo.each(authors).map { |switch, author|
      ERB.new(template).result_with_hash({switch:, author: Ryo(author)})
    }.join("\n")
  end
end
