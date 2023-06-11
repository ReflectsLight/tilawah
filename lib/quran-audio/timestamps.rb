# frozen_string_literal: true

class Timestamps
  require "mp3info"
  require "ryo"
  require "json"
  require_relative "cmd"
  include Cmd

  attr_reader :options

  def self.cli(argv)
    options = Ryo({reciter: "*"})
    OptionParser.new do |o|
      o.on("-r NAME", "--reciter NAME", "A reciter's name")
    end.parse(ARGV, into: options)
  end

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

  def reciter_dir
    @reciter_dir ||= File.join(share_dir, "recitations", options.reciter)
  end
end
