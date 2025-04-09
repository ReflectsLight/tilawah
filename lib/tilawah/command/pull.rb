# frozen_string_literal: true

module QuranAudio
  class Command::Pull < Command
    require "forwardable"
    extend Forwardable
    def_delegators :@options,
      :surahs,
      :recitation,
      :delay,
      :bitrate

    ##
    # @return [void]
    def perform
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
      http = Net::HTTP.new(mp3.host, 443).tap { _1.use_ssl = true }
      res = http.get(mp3.remote_path)
      write(mp3, res, interrupt:)
      sleep(delay)
    rescue Interrupt
      line.end.print("SIGINT: exiting cleanly, please wait").end
      pull(mp3, delay, interrupt: true)
    rescue SocketError, SystemCallError, Net::OpenTimeout => e
      line.end.print("#{e.class}: retry")
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
        .print("Recited by".ljust(12), r.name).end
        .print("Directory".ljust(12), format(r.destdir, sharedir: dir.share))
        .end.end
    end

    def sizeof
      @sizeof ||= Ryo.from_json(path: File.join(dir.json, "sizeof.json"))
    end

    def recitations
      @recitations ||= Ryo.from_json(path: File.join(dir.json, "recitations.json"))
    end

    def abort!
      throw(:abort, 1)
    end
  end
end
