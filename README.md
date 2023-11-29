## About

quran-audio is a command-line utility that can download recitations
of The Noble Quran from
[everyayah.com](https://everyayah.com).
The recitations are provided as MP3 files, with one MP3 file per ayah,
and the MP3 files are organized on disk by author, surah ID, and
ayah ID (eg `share/quran-audio/mp3/<author>/<surahid>/<ayahid>.mp3`).
The play time of each ayah is provided by the JSON files in the
[share/quran-audio/durations/](/share/quran-audio/durations/).
directory, and are organized by author.

## Usage

The examples assume git and Ruby v3+ are already installed,
alongside the RubyGem bundler.

**Clone repository**

    $ git clone https://github.com/ReflectsLight/quran-audio.git
    $ cd quran-audio

**Install dependencies***

    $ bundle install

**Run bin/quran-audio**

    $ bundle exec ruby bin/quran-audio --help

## Thanks

First and foremost, Alhamdulillah.

* Thanks to the [everyayah.com](https://everyayah.com) website.
* With thanks (and credit) to the recitation authors:
  * Mishari bin Rashed Alafasy
  * Aziz Alilli
  * Abdullah Awad Al Juhany
  * Ahmad bin Ali Al-Ajmi
  * Sahl Yassin

## License

The "source code" is released under the [GPL](./LICENSE) license.
