# frozen_string_literal: true

class MP3 < Struct.new(:author, :surah, :ayah, :bitrate, keyword_init: true)
  require_relative "command/mixin/path"
  include Command::Mixin::Path

  def initialize(author:, **kw)
    super(author: authors[author], **kw)
  end

  def bitrate
    super || author.default_bitrate
  end

  def remote_path
    filename = [surah.rjust(3, "0"), ayah.to_s.rjust(3, "0"), ".mp3"].join
    File.join format(author.remote_path, bitrate:), filename
  end

  def local_path
    File.join(
      format(author.dest_dir, share_dir: path.share_dir),
      surah.to_s,
      "#{ayah}.mp3"
    )
  end

  private

  def authors
    @authors ||= Ryo.from JSON.parse(File.binread(path.authors_file))
  end
end
