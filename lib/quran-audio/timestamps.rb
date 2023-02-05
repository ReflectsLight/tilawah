require_relative "command"
class Timestamps < Command
  require "mp3info"
  require "ryo"
  require "json"
  attr_reader :options

  def initialize(options)
    @timestamps = []
    @options = options
  end

  def push(path)
    mp3 = Mp3Info.new(path)
    @timestamps.push([
      File.basename(path, File.extname(path)).to_i,
      sprintf("%0.2f", mp3.length).to_f
    ])
  ensure
    mp3.close
  end

  def save(path)
    File.binwrite(
      File.join(path, "timestamps.json"),
      JSON.dump(@timestamps.sort_by(&:first))
    )
    @timestamps = []
  end

  def author_dir
    @author_dir ||= File.join(share_dir, "recitations", options.author)
  end
end
