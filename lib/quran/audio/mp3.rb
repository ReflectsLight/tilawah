# frozen_string_literal: true

module Quran::Audio
  class MP3 < Struct.new(:reciter, :surah, :ayah, :bitrate, keyword_init: true)
    def initialize(reciter:, **kw)
      super(reciter: reciters[reciter], **kw)
    end

    def bitrate
      super || reciter.default_bitrate
    end

    def remote_path
      filename = [surah.to_s.rjust(3, "0"), ayah.to_s.rjust(3, "0"), ".mp3"].join
      File.join format(reciter.remote_path, bitrate:), filename
    end

    def local_path
      File.join(
        format(reciter.dest_dir, sharedir:),
        surah.to_s,
        "#{ayah}.mp3"
      )
    end

    private

    def reciters
      @reciters ||= Ryo.from_json(path: File.join(datadir, "reciters.json"))
    end

    def sharedir
      @sharedir ||= begin
        localbase = File.join(Dir.home, ".local")
        File.join(localbase, "share", "quran-audio")
      end
    end

    def datadir
      @datadir ||= File.realpath File.join(
        __dir__, "..", "..", "..",
        "share", "quran-audio", "data"
      )
    end
  end
end
