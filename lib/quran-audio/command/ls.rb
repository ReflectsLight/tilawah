# frozen_string_literal: true

module QuranAudio
  class Command::Ls < Command
    ##
    # @return [void]
    def perform
      recitations = Ryo.from_json(path: File.join(dir.json, "recitations.json"))
      template = File.binread(File.join(dir.erb, "recitation.erb"))
      puts Ryo.each(recitations).map { |switch, recitation|
        ERB.new(template).result_with_hash({switch:, recitation: Ryo(recitation)})
      }.join("\n")
    end
  end
end
