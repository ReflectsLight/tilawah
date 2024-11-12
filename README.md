## About

quran-audio is a command-line utility that
can download recitations of The Noble Quran from
[al-quran-audio.reflectslight.io](https://al-quran-audio.reflectslight.io).
The recitations are provided in the MP3 format with
one MP3 file per ayah and a *minimum* bitrate of
128kbps.

## share/

* **~/.local/share/quran-audio/mp3/alafasy/** <br>
  Contains recitations by Mishari bin Rashed Alafasy
* **~/.local/share/quran-audio/mp3/alajmi/** <br>
  Contains recitations by Ahmad bin Ali Al-Ajmi
* **~/.local/share/quran-audio/mp3/yassin/** <br>
  Contains recitations by Sahl Yassin
* **~/.local/share/quran-audio/mp3/rifai/** <br>
  Contains recitations by Hani ar-Rifai

## Examples

    # Download 'alafasy' recitation
    user@localhost$ quran-audio pull -r alafasy

    # Download 'rifai' recitation
    user@localhost$ quran-audio pull -r rifai

    # List recitations
    user@localhost$ quran-audio ls

## Install

quran-audio is available via rubygems.org:

    user@localhost$ gem install quran-audio

## Thanks

الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ


* Thanks to the [everyayah.com](https://everyayah.com) website
* Thanks to the reciters

## License

The "source code" is released under the [GPL](./LICENSE) license
<br>
The reciters hold the copyright for the audio files
