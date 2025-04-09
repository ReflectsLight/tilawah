<p align="center">
الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِي
</p>

## About

tilawah is a command-line utility that
can download recitations of The Noble Quran from
[al-quran-audio.reflectslight.io](https://al-quran-audio.reflectslight.io).
The recitations are provided in the MP3 format with
one MP3 file per ayah and a *minimum* bitrate of
128kbps.

## CLI

#### Commands

* **tilawah pull** <br>
  The pull command downloads recitations. <br>
  For example:

	    user@mecca$ tilawah pull -r alafasy

* **tilawah ls** <br>
  The ls command lists the recitations available for download. <br>
  For example:

        user@medina$ tilawah ls

## share/

The command-line utility attempts to download MP3 files
relative to the `~/.local/share/tilawah/` directory.
A single, full recitation of The Noble Quran typically
ranges from 2.5GB to 2.8GB in size.

The directory layout:

* **~/.local/share/tilawah/mp3/alafasy/** <br>
  Contains recitations by Mishari bin Rashed Alafasy
* **~/.local/share/tilawah/mp3/yassin/** <br>
  Contains recitations by Sahl Yassin
* **~/.local/share/tilawah/mp3/rifai/** <br>
  Contains recitations by Hani ar-Rifai

## Install

tilawah is available via rubygems.org

    gem install tilawah

## Credit

**Recitations**

* Mishari bin Rashed Alafasy
* Sahl Yassin
* Hani ar-Rifai

**Sources**

* The [everyayah.com](https://everyayah.com) website

## See also

* [al-quran.reflectslight.io](https://al-quran.reflectslight.io)
* [al-tilawah.reflectslight.io](https://al-quran-audio.reflectslight.io)

## License

The "source code" is released under the [GPL](./LICENSE) license
<br>
Copyright for the recitations belongs to the reciters
