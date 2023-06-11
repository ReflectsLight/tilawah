# frozen_string_literal: true

class Pull
  require "optparse"
  require "net/http"
  require "fileutils"
  require_relative "command"
  include FileUtils
  include Command

  attr_reader :http,
              :options

  def self.cli
    Ryo.from({
      options: [
        ["-r NAME", "--reciter NAME", "The name of a reciter"],
        ["-b BITRATE", "--bitrate BITRATE", "MP3 bitrate"],
        ["-s SURAHS", "--surah SURAHS", "Comma-separated list of surah numbers", Array],
        ["-c SECONDS", "--cooldown SECONDS", "Cooldown period between requests", Float],
      ],
      defaults: {
        reciter: "alafasy",
        bitrate: nil,
        surah: (1..114).to_a,
        cooldown: 0.5
      },
      parse: Ryo.fn { |argv|
        op = nil
        into = Ryo.dup(defaults)
        OptionParser.new(nil, 26, " " * 2) do |o|
          op = o
          op.banner = "Usage: quran-audio pull [OPTIONS]"
          op.on("-h", "--help", "Show help") { puts(op.help).then { exit } }
          options.each { op.on(*_1) }
        end.parse(argv, into:).then { into }
      }
    })
  end

  def initialize(argv)
    @http = Net::HTTP.new("everyayah.com", 443).tap { _1.use_ssl = true }
    @options = Pull.cli.parse.(argv)
  end

  def pull(surah, ayah, interrupt: false)
    res = http.get request_path(surah, ayah)
    store(res, "#{surah}/#{ayah}.mp3", interrupt:)
    sleep(options.cooldown)
  rescue Interrupt
    line.end.rewind.print("Wait for a graceful exit").end
    pull(surah, ayah, interrupt: true)
  rescue SocketError, SystemCallError, Net::OpenTimeout => e
    line.end.rewind.print("#{e.class}: retry")
    interrupt ? throw(:interrupt, true) : pull(surah, ayah)
  end

  def reciter
    @reciter ||= reciters[options.reciter]
  end

  def bitrate
    options.bitrate || reciter.default_bitrate
  end

  def exist?(surah, ayah)
    File.exist? File.join(format(reciter.dest_dir, share_dir:),
                          surah.to_s,
                          "#{ayah}.mp3")
  end

  private

  def request_path(surah, ayah)
    surah = surah.rjust(3, "0")
    ayah = ayah.to_s.rjust(3, "0")
    filename = "#{surah}#{ayah}.mp3"
    File.join format(reciter.request_path, bitrate:), filename
  end

  def store(res, filename, interrupt:)
    case res
    when Net::HTTPOK
      dir = format(reciter.dest_dir, share_dir:)
      path = File.join(dir, filename)
      mkdir_p File.dirname(path)
      File.binwrite(path, res.body)
      throw(:interrupt, true) if interrupt
    else
      puts "error #{res.body}"
    end
  end
end
