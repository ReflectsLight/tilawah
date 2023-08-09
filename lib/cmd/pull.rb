# frozen_string_literal: true

require "net/http"
require "fileutils"
require "json"
require_relative "../mp3"
require_relative "../cmd"
require_relative "../cmd/mixins/path"

class Cmd::Pull < Cmd
  set_banner usage: "quran-audio pull [OPTIONS]",
             description: "Download MP3 files from everyayah.com."
  set_option "-a AUTHOR", "--author AUTHOR", "An author's name"
  set_option "-b BITRATE", "--bitrate BITRATE", "MP3 bitrate"
  set_option "-s NUMBERS", "--surahs NUMBERS", "Comma-separated list of surah numbers", Array
  set_option "-d SECONDS", "--delay", "Delay between requests, in seconds", Float
  set_default author: "alafasy", surahs: (1..114).to_a, delay: 0.5

  include FileUtils
  include Cmd::Path

  attr_reader :http

  def initialize(argv)
    super(argv)
    @http = Net::HTTP.new("everyayah.com", 443).tap { _1.use_ssl = true }
    @surah_length = JSON.parse File.binread(path.length_file)
  end

  def run
    options = parse!(argv)
    options.help ? show_help : run_command(options)
  end

  private

  def run_command(options)
    surahs  = options.surahs
    author  = options.author
    bitrate = options.bitrate
    surahs.each do |surah|
      1.upto(surah_length(surah)) do |ayah|
        mp3 = MP3.new(author:, surah:, ayah:, bitrate:)
        pull(mp3, options.delay) unless File.exist?(mp3.local_path)
        percent = sprintf("%.2f", (ayah / surah_length(surah).to_f) * 100)
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
    interrupt ? throw(:interrupt, true) : pull(mp3, delay)
  end

  def write(mp3, res, interrupt:)
    case res
    when Net::HTTPOK
      mkdir_p File.dirname(mp3.local_path)
      File.binwrite(mp3.local_path, res.body)
      throw(:interrupt, true) if interrupt
    else
      puts "error #{res.body}"
    end
  end

  def surah_length(surah)
    @surah_length[surah.to_s]
  end
end
