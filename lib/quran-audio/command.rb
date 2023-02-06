class Command
  require "ryo"
  require "io/line"
  require "json"

  ##
  # @return [String]
  #  Returns the absolute path to the root directory.
  def root_dir
    File.realpath File.join(__dir__, "..", "..")
  end

  ##
  # @return [String]
  #  Returns the absolute path to the share directory.
  def share_dir
    File.join(root_dir, "share", "quran-audio")
  end

  ##
  # @return [String]
  #  Returns the absolute path to the data directory.
  def data_dir
    File.join(share_dir, "data")
  end

  ##
  # @return [Ryo::Object]
  #  Returns a Ryo object that holds all known authors.
  def authors
    @authors ||= Ryo.from(
      JSON.parse File.binread(File.join(data_dir, "authors.json"))
    )
  end

  ##
  # @return [Ryo::Object<{surah => count}>]
  #  Returns a Ryo object that maps a surah number to its ayah count.
  def count
    @count ||= Ryo.from(
      JSON.parse File.binread(File.join(data_dir, "count.json"))
    )
  end

  ##
  # @return [IO::Line]
  def line
    @line ||= IO::Line.new($stdout)
  end
end
