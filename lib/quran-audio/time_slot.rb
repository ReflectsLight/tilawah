# frozen_string_literal: true

class TimeSlot
  require "mp3info"
  require "ryo"
  require "json"
  require_relative "cmd"
  include Cmd

  attr_reader :options

  def self.cli(argv)
    Ryo.from({
      options: [
        ["-r NAME", "--reciter NAME", "The name of a reciter"]
      ],
      defaults: {reciter: "*"},
      parse: Ryo.fn {
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
    @slots = []
    @options = TimeSlot.cli(argv).parse.()
  end

  def push(path)
    mp3 = Mp3Info.new(path)
    @slots.push([
      File.basename(path, File.extname(path)).to_i,
      sprintf("%0.2f", mp3.length).to_f
    ])
  ensure
    mp3.close
  end

  def save(path)
    File.binwrite(
      path,
      JSON.dump(@slots.sort_by(&:first))
    )
    @slots = []
  end

  def reciter_dir
    @reciter_dir ||= File.join(share_dir, "recitations", options.reciter)
  end
end
