<p align="center">
الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِي
</p>

## About

tilawah is a command-line utility that
can download recitations of The Noble Quran from
[al-quran-audio.reflectslight.io](https://al-quran-audio.reflectslight.io)
and/or [everyayh.com](https://everyayah.com) to your
computer. The recitations are provided in the MP3 format
with one MP3 file per ayah and a *minimum* bitrate of
128kbps.

The command-line utility attempts to download MP3 files
relative to the `${HOME}/.local/share/tilawah/` directory.
A single, full recitation of The Noble Quran typically
ranges from 2.5GB to 2.8GB in size.

The directory layout:

* `${HOME}/.local/share/tilawah/mp3/alafasy/` <br>
  Contains recitations by Mishari bin Rashed Alafasy
* `${HOME}/.local/share/tilawah/mp3/yassin/` <br>
  Contains recitations by Sahl Yassin
* `${HOME}/.local/share/tilawah/mp3/rifai/` <br>
  Contains recitations by Hani ar-Rifai
* `${HOME}/.local/share/tilawah/mp3/aljuhany/` <br>
  Contains recitations by Abdullah Awad Al Juhany

## Credit

**Recitations**

* Mishari bin Rashed Alafasy
* Sahl Yassin
* Hani ar-Rifai
* Abdullah Awad Al Juhany

**Sources**

* The [everyayah.com](https://everyayah.com) website

## Install

tilawah is available via rubygems.org

    gem install tilawah

## See also

* [al-quran.reflectslight.io](https://al-quran.reflectslight.io)
* [al-quran-audio.reflectslight.io](https://al-quran-audio.reflectslight.io)

## License

The "source code" is released under the [GPL](./LICENSE) license
<br>
Copyright for the recitations belongs to the reciters
