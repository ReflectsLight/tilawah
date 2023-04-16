__About__

quran-audio is a command-line utility that can download recitations
of The Quran from
[everyayah.com](https://everyayah.com).
There are multiple reciters to choose from, one MP3 file per ayah, and
the downloaded content is neatly organized on disk (eg
`<reciter>/<surah_no>/<ayah_no>.mp3`)

__Reciters__

<table>
  <tr>
    <th>Name</th>
    <th>From</th>
    <th>Bitrates</th>
    <th>CLI</th>
  </tr>
  <tr>
    <td>Mishari bin Rashed Alafasy</td>
    <td>Kuwait</td>
    <td>128, 64 (default = 128)</td>
    <td>--reciter alafasy</td>
  </tr>
  <tr>
    <td>Aziz Alili</td>
    <td>Macedonia</td>
    <td>128 (default = 128)</td>
    <td>--reciter aziz_alili</td>
  </tr>
  <tr>
    <td>Abdullah Awad Al Juhany</td>
    <td>Saudi Arabia</td>
    <td>128 (default = 128)</td>
    <td>--reciter abdullah_awad_al_juhany  </td>
  </tr>
  <tr>
    <td> Ahmad bin Ali Al-Ajmi  </td>
    <td>Saudi Arabia</td>
    <td>128 (default = 128)</td>
    <td>--reciter ahmad_bin_ali_al_ajmi</td>
  </tr>
</table>

__CLI__

    Usage: quran-audio pull [OPTIONS]
    -h, --help                 Show help
    -r, --reciter NAME         The name of a reciter
    -b, --bitrate BITRATE      MP3 bitrate
    -s, --surah SURAHS         Comma-separated list of surah numbers
    -c, --cooldown SECONDS     Cooldown period between requests
    -d, --display              Display the list of reciters

__Thanks__

First and foremost, Alhamdulillah.

* Thanks to the [everyayah.com](https://everyayah.com) website.
* With thanks (and credit) to the reciters:
  * Mishari bin Rashed Alafasy
  * Aziz Alilli
  * Abdullah Awad Al Juhany
  * Ahmad bin Ali Al-Ajmi

__License__

The "source code" is released under the [GPL](./LICENSE) license.
