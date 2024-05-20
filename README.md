## About

quran-audio is a command-line utility that can download recitations
of The Noble Quran from
[everyayah.com](https://everyayah.com).
The recitations are provided as MP3 files, with one MP3 file per ayah,
and the MP3 files are organized on disk by author, surah ID, and
ayah ID.

## Usage

    # Clone repository
    $ git clone https://github.com/ReflectsLight/quran-audio.git
    $ cd quran-audio

    # Install dependencies
    $ bundle install

    # Run bin/quran-audio
    $ bundle exec ruby bin/quran-audio --help

## Format, durations

An ayah from a given author is stored on disk in the following
format: `share/quran-audio/mp3/<author>/<surahid>/<ayahid>.mp3`. 

The playtime of each ayah is provided by a JSON file in the
[share/quran-audio/durations/](/share/quran-audio/durations/)
directory.

## Thanks

Alhamdulillah

* Thanks to the [everyayah.com](https://everyayah.com) website
* Thanks to the reciters
    * Mishari bin Rashed Alafasy
    * Aziz Alilli
    * Abdullah Awad Al Juhany
    * Ahmad bin Ali Al-Ajmi
    * Sahl Yassin

## License

The "source code" is released under the [GPL](./LICENSE) license
<br>
The reciters hold the copyright for the audio files
