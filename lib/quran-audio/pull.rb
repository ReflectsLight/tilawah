class Pull
  require "optparse"
  require "net/http"
  require "fileutils"
  require_relative "command"
  require_relative "pull/authors"
  include FileUtils
  include Command

  attr_reader :http
  attr_reader :options

  def self.cli(argv)
    options = Ryo(author: "alafasy", bitrate: nil, surah: (1..114).to_a, cooldown: 0.5)
    op = nil
    OptionParser.new(nil, 26, " " * 2) do |o|
      op = o
      o.banner = "Usage: quran-audio pull [OPTIONS]"
      o.on("-aNAME", "--author NAME", "An author's name (default: alafasy)")
      o.on("-bBITRATE", "--bitrate BITRATE", "An MP3 bitrate (default: highest available)")
      o.on("-sSURAH", "--surah SURAH", "A comma-separated list of surahs (default: all surahs)", Array)
      o.on("-cNUMBER", "--cooldown NUMBER", "A number of second(s) to wait between requests (default: 0.5)", Float)
      o.on("-l", "--authors", "Show the available authors")
      o.on("-h", "--help", "Show help") do
        puts op.help
        exit(0)
      end
    end.parse(argv, into: options)
  end

  def initialize(options)
    @http = Net::HTTP.new("everyayah.com", 443).tap { _1.use_ssl = true }
    @options = options
  end

  def pull(surah_no, ayah_no)
    interrupt ||= nil
    res = http.get http_path(surah_no, ayah_no)
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

  def author
    @author ||= authors[options.author]
  end

  def bitrate
    options.bitrate || author.audio.default_bitrate
  end

  def exist?(surah_no, ayah_no)
    File.exist? fs_path(surah_no, ayah_no)
  end

  private

  def http_path(surah_no, ayah_no)
    surah_no  = surah_no.rjust(3, "0")
    ayah_no   = ayah_no.to_s.rjust(3, "0")
    http_file ="#{surah_no}#{ayah_no}.mp3"
    File.join format(author.http.path, bitrate:), http_file
  end

  def fs_path(surah_no, ayah_no)
    dir = format(author.dest.dir, share_dir:)
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
