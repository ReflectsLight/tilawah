# frozen_string_literal: true

require "ryo"
Settings = Ryo.from({
  root_dir: Ryo.lazy { File.realpath(File.join(__dir__, "..", "..")) },
  share_dir: Ryo.lazy { File.join(root_dir, "share", "quran-audio") },
  data_dir: Ryo.lazy { File.join(share_dir, "data") },
  reciters: Ryo.lazy { Ryo.from JSON.parse(File.binread(reciters_path)) },
  reciters_path: Ryo.lazy { File.join(data_dir, "reciters.json") }
})
