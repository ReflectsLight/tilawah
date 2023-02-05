class Command
  require "ryo"
  require "io/line"
  require "json"

  def root_dir
    File.realpath File.join(__dir__, "..", "..")
  end

  def share_dir
    File.join(root_dir, "share", "quran-audio")
  end

  def authors
    Ryo.from JSON.parse(File.binread(File.join(share_dir, "authors.json")))
  end

  def surah_size
    Ryo.from JSON.parse(File.binread(File.join(share_dir, "surahsize.json")))
  end

  def line
    @line ||= IO::Line.new($stdout)
  end
end
