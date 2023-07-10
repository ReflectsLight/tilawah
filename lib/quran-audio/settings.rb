# frozen_string_literal: true

require "ryo"
Settings = Ryo.from({
  get_root_dir: Ryo.fn { File.realpath(File.join(__dir__, "..", "..")) },
  get_share_dir: Ryo.fn { File.join(get_root_dir.(), "share", "quran-audio") },
  get_data_dir: Ryo.fn { File.join(get_share_dir.(), "data") },
  get_reciters: Ryo.fn { Ryo.from JSON.parse(File.binread(get_reciters_path.call)) },
  get_reciters_path: Ryo.fn { File.join(get_data_dir.(), "reciters.json") }
})
