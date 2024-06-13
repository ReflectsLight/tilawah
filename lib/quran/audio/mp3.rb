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
        format(author.dest_dir, share_dir:),
        surah.to_s,
        "#{ayah}.mp3"
      )
    end

    private

    def authors
      @authors ||= Ryo.from_json(path: authors_file)
    end

    def share_dir
      @share_dir ||= File.realpath File.join(
        __dir__, "..", "..", "..",
        "share", "quran-audio"
      )
    end

    def authors_file
      File.join share_dir, "data", "authors.json"
    end
  end
end
