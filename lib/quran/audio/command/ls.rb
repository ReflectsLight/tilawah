# frozen_string_literal: true

module Quran::Audio
  class Command::Ls < Command
    set_banner usage: "quran-audio ls [OPTIONS]",
               description: "List reciters"

    def run
      reciters = Ryo.from_json(path: File.join(dir.datadir, "reciters.json"))
      template = File.binread(File.join(dir.datadir, "erb", "reciter.erb"))
      render(reciters, template)
    end

    private

    def render(reciters, template)
      puts Ryo.each(reciters).map { |switch, reciter|
        ERB.new(template).result_with_hash({switch:, reciter: Ryo(reciter)})
      }.join("\n")
    end
  end
end
