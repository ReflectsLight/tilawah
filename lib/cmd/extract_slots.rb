# frozen_string_literal: true

require "mp3info"
require "ryo"
require "json"
require_relative "../cmd"

class Cmd::ExtractSlots < Cmd
  set_banner usage: "quran-audio extract-slots [OPTIONS]",
             description: "Extract time slots from MP3 files."
  set_option "-a NAME", "--author NAME", "An author's name"
  set_default author: "*"
  include FileUtils

  def run
    options = parse!(argv)
    options.help ? show_help : run_command(options)
  end

  private

  def run_command(options)
    author_dir = File.join(share_dir, "recitations", options.author)
    Dir.glob(File.join(author_dir, "[0-9]*")).each do |dir|
      slots = []
      Dir.glob(File.join(dir, "*.mp3")).each { push(slots, _1) }
      dest_dir = File.join(File.dirname(dir), "slots")
      dest_file = File.join(dest_dir, "#{File.basename(dir)}.json")
      mkdir_p(dest_dir)
      write(slots, dest_file)
      print "Write: #{dest_file.sub(Dir.getwd + "/", "")}", "\n"
    end
  end

  def push(slots, path)
    mp3 = Mp3Info.new(path)
    ayah_no = File.basename(path, File.extname(path)).to_i
    seconds = sprintf("%0.2f", mp3.length).to_f
    slots.push([ayah_no, seconds])
  ensure
    mp3.close
  end

  def write(slots, path)
    json = JSON.dump(slots.sort_by(&:first))
    File.binwrite(path, json)
  end
end
