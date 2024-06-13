# frozen_string_literal: true

module Quran::Audio
  ##
  # {Quran::Audio::MP3 Quran::Audio::MP3} provides
  # an abstract interface around an MP3 file, and
  # within the context of the quran-audio project.
  class MP3 < Struct.new(:recitation, :surah, :ayah, :bitrate, keyword_init: true)
    def initialize(recitation:, **kw)
      super(recitation: recitations[recitation], **kw)
    end

    ##
    # @return [String]
    #  Returns the bitrate of an MP3 file
    def bitrate
      super || recitation.default_bitrate
    end

    ##
    # @return [String]
    #  Returns the path to an MP3 file on a remote HTTP server
    def remote_path
      filename = [surah.to_s.rjust(3, "0"), ayah.to_s.rjust(3, "0"), ".mp3"].join
      File.join format(recitation.path, bitrate:), filename
    end

    ##
    # @return [String]
    #  Returns the path to an MP3 file on disk
    def local_path
      File.join(
        format(recitation.destdir, sharedir:),
        surah.to_s,
        "#{ayah}.mp3"
      )
    end

    private

    def recitations
      @recitations ||= Ryo.from_json(path: File.join(datadir, "recitations.json"))
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
