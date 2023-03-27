# frozen_string_literal: true

class Pull
  require "optparse"
  require "net/http"
  require "fileutils"
  require_relative "command"
  require_relative "reciter_index"
  include FileUtils
  include Command

  attr_reader :http,
              :options

  def self.parse_cli(argv)
    op = nil
    options = cli_defaults
    OptionParser.new(nil, 26, " " * 2) do |o|
      op = o
      op.banner = "Usage: quran-audio pull [OPTIONS]"
      op.on("-h", "--help", "Show help") { puts(op.help).then { exit } }
      cli_options.each { op.on(*_1) }
    end.parse(argv, into: options).then { options }
  end

  def self.cli_options
    [
      ["-r NAME", "--reciter NAME", "The name of a reciter"],
      ["-b BITRATE", "--bitrate BITRATE", "MP3 bitrate"],
      ["-s SURAHS", "--surah SURAHS", "Comma-separated list of surah numbers", Array],
      ["-c SECONDS", "--cooldown SECONDS", "Cooldown period between requests", Float],
      ["-p", "--print", "Prints a list of reciters"]
    ]
  end

  def self.cli_defaults
    Ryo(
      reciter: "alafasy",
      bitrate: nil,
      surah: (1..114).to_a,
      cooldown: 0.5
    )
  end

  def initialize(argv)
    @http = Net::HTTP.new("everyayah.com", 443).tap { _1.use_ssl = true }
    @options = self.class.parse_cli(argv)
  end

  def pull(surah_no, ayah_no)
    interrupt ||= nil
    res = http.get http_path(surah_no, ayah_no), http_headers
    write(res, fs_path(surah_no, ayah_no), interrupt)
    sleep(options.cooldown)
  rescue Interrupt
    line.end.rewind.print("Wait for a graceful exit").end
    interrupt = true
    retry
  rescue SocketError, SystemCallError, Net::OpenTimeout => e
    line.end.rewind.print("#{e.class}: retry")
    interrupt = nil
    retry
  end

  def reciter
    @reciter ||= reciters[options.reciter]
  end

  def bitrate
    options.bitrate || reciter.default_bitrate
  end

  def exist?(surah_no, ayah_no)
    File.exist? fs_path(surah_no, ayah_no)
  end

  private

  def http_path(surah_no, ayah_no)
    surah_no = surah_no.rjust(3, "0")
    ayah_no = ayah_no.to_s.rjust(3, "0")
    http_file = "#{surah_no}#{ayah_no}.mp3"
    File.join format(reciter.download_path, bitrate:), http_file
  end

  def http_headers
    @http_headers ||= {
      "user-agent" => "quran-audio (https://github.com/ReflectsLight/quran-audio#readme)"
    }
  end

  def fs_path(surah_no, ayah_no)
    dir = format(reciter.dest_dir, share_dir:)
    File.join(dir, surah_no.to_s, "#{ayah_no}.mp3")
  end

  def write(res, fs_file, interrupt)
    case res
    when Net::HTTPOK
      mkdir_p File.dirname(fs_file)
      File.binwrite(fs_file, res.body)
      exit if interrupt
    else
      puts "error #{res.body}"
    end
  end
end
