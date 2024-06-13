# frozen_string_literal: true

module Quran::Audio
  class MP3 < Struct.new(:author, :surah, :ayah, :bitrate, keyword_init: true)
    def initialize(author:, **kw)
      super(author: authors[author], **kw)
    end

    def bitrate
      super || author.default_bitrate
    end

    def remote_path
      filename = [surah.to_s.rjust(3, "0"), ayah.to_s.rjust(3, "0"), ".mp3"].join
      File.join format(author.remote_path, bitrate:), filename
    end

    def local_path
      File.join(
        format(author.dest_dir, sharedir:),
        surah.to_s,
        "#{ayah}.mp3"
      )
    end

    private

    def authors
      @authors ||= Ryo.from_json(path: File.join(datadir, "authors.json"))
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
