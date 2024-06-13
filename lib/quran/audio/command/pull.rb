# frozen_string_literal: true

module Quran::Audio
  class Command::Pull < Command
    set_banner usage: "quran-audio pull [OPTIONS]",
               description: "Pull MP3 files from everyayah.com"
    set_option "-r RECITATION", "--recitation RECITATION", "A recitation's name", default: "alafasy"
    set_option "-b BITRATE", "--bitrate BITRATE", "MP3 bitrate"
    set_option "-s NUMBERS", "--surahs NUMBERS", "Comma-separated list of surah IDs", as: Array, default: (1..114)
    set_option "-d SECONDS", "--delay", "Delay between requests, in seconds", as: Float, default: 0.5

    def initialize(...)
      super
      @http = Net::HTTP.new("everyayah.com", 443).tap { _1.use_ssl = true }
    end

    def run
      summary(recitations[recitation])
      start(surahs)
    end

    private

    attr_reader :http

    def start(surahs)
      surahs.each do |surah|
        1.upto(sizeof[surah]) do |ayah|
          mp3 = MP3.new(recitation:, surah:, ayah:, bitrate:)
          pull(mp3, delay) unless File.exist?(mp3.local_path)
          percent = sprintf("%.2f", (ayah / sizeof[surah].to_f) * 100)
          line.rewind.print "Surah #{surah} [#{percent}%]"
        end
        line.end
      end
    end

    def pull(mp3, delay, interrupt: false)
      res = http.get(mp3.remote_path)
      write(mp3, res, interrupt:)
      sleep(delay)
    rescue Interrupt
      line.end.rewind.print("Wait for a graceful exit").end
      pull(mp3, delay, interrupt: true)
    rescue SocketError, SystemCallError, Net::OpenTimeout => e
      line.end.rewind.print("#{e.class}: retry")
      interrupt ? abort! : pull(mp3, delay)
    end

    def write(mp3, res, interrupt:)
      case res
      when Net::HTTPOK
        mkdir_p File.dirname(mp3.local_path)
        File.binwrite(mp3.local_path, res.body)
        abort! if interrupt
      else
        line.end.print("error: unexpected response (#{res.class})")
        abort!
      end
    end

    def summary(r)
      line
        .rewind
        .print("Recitation".ljust(12), r.name).end
        .print("Directory".ljust(12), format(r.destdir, sharedir: dir.sharedir))
        .end.end
    end

    def sizeof
      @sizeof ||= Ryo.from_json(path: File.join(dir.datadir, "sizeof.json"))
    end

    def recitations
      @recitations ||= Ryo.from_json(path: File.join(dir.datadir, "recitations.json"))
    end

    def abort!
      throw(:abort, 1)
    end
  end
end
