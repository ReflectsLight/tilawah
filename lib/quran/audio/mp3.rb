# frozen_string_literal: true

module Quran::Audio
  ##
  # {Quran::Audio::MP3 Quran::Audio::MP3} represents
  # an ayah of The Noble Quran in the MP3 format.
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
    #  Returns the host of a remote HTTP server
    def host
      recitation.host
    end

    ##
    # @return [String]
    #  Returns the path to an MP3 file on a remote HTTP server
    def remote_path
      File.join format(recitation.path, bitrate:),
                [surah, "/", ayah, ".mp3"].join
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
      @recitations ||= Ryo.from_json(path: File.join(jsondir, "recitations.json"))
    end

    def sharedir
      @sharedir ||= begin
        localbase = File.join(Dir.home, ".local")
        File.join(localbase, "share", "quran-audio")
      end
    end

    def jsondir
      @jsondir ||= File.realpath File.join(
        __dir__, "..", "..", "..",
        "share", "quran-audio", "json"
      )
    end
  end
end
