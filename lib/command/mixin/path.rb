module Command::Mixin
  module Path
    def path
      @path ||= Ryo.from({
        root_dir: Ryo.lazy { File.realpath(File.join(__dir__, "..", "..", "..")) },
        share_dir: Ryo.lazy { File.join(root_dir, "share", "quran-audio") },
        data_dir: Ryo.lazy { File.join(share_dir, "data") },
        authors_file: Ryo.lazy { File.join(data_dir, "authors.json") },
        length_file: Ryo.lazy { File.join(data_dir, "surah_length.json") }
      })
    end
  end
end
