# frozen_string_literal: true

module Quran::Audio
  class Command::Ls < Command
    set_banner usage: "quran-audio ls [OPTIONS]",
               description: "List reciters"

    def run
      authors  = Ryo.from_json(path: File.join(dir.datadir, "authors.json"))
      template = File.binread(File.join(dir.datadir, "erb", "author.txt.erb"))
      render(authors, template)
    end

    private

    def render(authors, template)
      puts Ryo.each(authors).map { |switch, author|
        ERB.new(template).result_with_hash({switch:, author: Ryo(author)})
      }.join("\n")
    end
  end
end
