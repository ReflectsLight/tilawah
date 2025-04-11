# frozen_string_literal: true

module Tilawah
  ##
  # {Tilawah::MP3 Tilawah::MP3} represents an ayah of
  # The Noble Quran in the MP3 format.
  class MP3 < Struct.new(:recitation, :surah, :ayah, :bitrate, keyword_init: true)
    def initialize(recitation:, **kw)
      super(recitation: Tilawah.recitations[recitation], **kw)
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
      case host
      when "everyayah.com"
        File.join format(recitation.path, bitrate:)
                  [surah.to_s.rjust(3, "0"), ayah.to_s.rjust(3, "0"), ".mp3"].join
      else
        File.join format(recitation.path, bitrate:),
                  [surah, "/", ayah, ".mp3"].join
      end
    end

    ##
    # @return [String]
    #  Returns the path to an MP3 file on disk
    def local_path
      File.join(
        format(recitation.destdir, sharedir: Tilawah.paths.share),
        surah.to_s,
        "#{ayah}.mp3"
      )
    end
  end
end
