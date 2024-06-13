## About

quran-audio is a command-line utility that
can download recitations of The Noble Quran from
[everyayah.com](https://everyayah.com).
The recitations are provided as MP3 files
(with one MP3 file per ayah).

## ~/.local/share/quran-audio/

By default downloads are stored relative to
`~/.local/share/quran-audio`.  <br> Otherwise
`$XDG_DATA_HOME/quran-audio` can be used instead.

* **~/.local/share/quran-audio/mp3/alafasy/** <br>
  Contains recitations by Mishari bin Rashed Alafasy
* **~/.local/share/quran-audio/mp3/alajmi/** <br>
  Contains recitations by Ahmad bin Ali Al-Ajmi
* **~/.local/share/quran-audio/mp3/yassin/** <br>
  Contains recitations by Sahl Yassin

An example path:
`/home/user/.local/share/quran-audio/mp3/alafasy/1/1.mp3`.

## Usage

    # Clone
    git clone https://github.com/ReflectsLight/quran-audio
    cd quran-audio

    # Install
    bundle install
    bundle exec ruby bin/quran-audio --help

## Thanks

Alhamdulillah

* Thanks to the [everyayah.com](https://everyayah.com) website
* Thanks to the reciters

## License

The "source code" is released under the [GPL](./LICENSE) license
<br>
The reciters hold the copyright for the audio files
