# frozen_string_literal: true

module Tilawah
  class Command::Ls < Command
    ##
    # @return [void]
    def perform
      Ryo.each(Tilawah.recitations) do |switch, recitation|
        erb = ERB.new(template)
        print erb.result_with_hash({switch:, recitation: Ryo(recitation)}), "\n"
      end
    end

    private

    def template
      File.binread File.join(Tilawah.paths.erb, "recitation.erb")
    end
  end
end
