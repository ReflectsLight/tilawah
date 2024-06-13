# frozen_string_literal: true

module Quran::Audio
  class Command::Ls < Command
    set_banner usage: "quran-audio ls [OPTIONS]",
               description: "List recitations"

    def run
      recitations = Ryo.from_json(path: File.join(dir.datadir, "recitations.json"))
      template = File.binread(File.join(dir.datadir, "erb", "recitation.erb"))
      render(recitations, template)
    end

    private

    def render(recitations, template)
      puts Ryo.each(recitations).map { |switch, recitation|
        ERB.new(template).result_with_hash({switch:, recitation: Ryo(recitation)})
      }.join("\n")
    end
  end
end
