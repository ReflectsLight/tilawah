require_relative "command"
class Pull < Command
  require "net/http"
  require "fileutils"
  include FileUtils

  attr_reader :http
  attr_reader :options

  def initialize(options)
    @http = Net::HTTP.new("everyayah.com", 443).tap { _1.use_ssl = true }
    @options = options
  end

  def pull(author, surah_no, ayah_no)
    interrupt ||= nil
    res = http.get http_path(author, surah_no, ayah_no)
    write(res, fs_path(author, surah_no, ayah_no), interrupt)
    sleep(options.cooldown)
  rescue Interrupt
    line.end.rewind.print("Wait for a graceful exit").end
    interrupt = true
    retry
  rescue SystemCallError, Net::OpenTimeout => e
    line.end.rewind.print("#{e.class}: retry").end
    interrupt = nil
    retry
  end

  def bitrate
    options.bitrate
  end

  def exist?(author, surah_no, ayah_no)
    File.exist? fs_path(author, surah_no, ayah_no)
  end

  private

  def http_path(author, surah_no, ayah_no)
    surah_no  = surah_no.rjust(3, "0")
    ayah_no   = ayah_no.to_s.rjust(3, "0")
    http_file ="#{surah_no}#{ayah_no}.mp3"
    File.join format(author.http.path, bitrate: bitrate), http_file
  end

  def fs_path(author, surah_no, ayah_no)
    dir = format(author.dest.dir, share_dir:)
    File.join(dir, surah_no.to_s, "#{ayah_no}.mp3")
  end

  def write(res, fs_file, interrupt)
    case when Net::HTTPOK
      mkdir_p File.dirname(fs_file)
      File.binwrite(fs_file, res.body)
      exit if interrupt
    else
      puts "error #{res.body}"
    end
  end
end
