__About__

quran-audio is a command-line utility that can download recitations
of The Quran from
[everyayah.com](https://everyayah.com).
There are multiple reciters to choose from, one MP3 file per ayah, and
the downloaded content is neatly organized on disk (eg
`<reciter>/<surah_no>/<ayah_no>.mp3`)

__Authors__

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
    <td>--author alafasy</td>
  </tr>
  <tr>
    <td>Aziz Alili</td>
    <td>Macedonia</td>
    <td>128 (default = 128)</td>
    <td>--author aziz_alili</td>
  </tr>
  <tr>
    <td>Abdullah Awad Al Juhany</td>
    <td>Saudi Arabia</td>
    <td>128 (default = 128)</td>
    <td>--author abdullah_awad_al_juhany  </td>
  </tr>
  <tr>
    <td> Ahmad bin Ali Al-Ajmi  </td>
    <td>Saudi Arabia</td>
    <td>128 (default = 128)</td>
    <td>--author ahmad_bin_ali_al_ajmi</td>
  </tr>
  <tr>
    <td>Sahl Yassin</td>
    <td>Saudi Arabia</td>
    <td>128 (default = 128)</td>
    <td>--author sahl_yassin</td>
  </tr>
</table>

__CLI__

* All commands

        Usage: quran-audio [COMMAND] [OPTIONS]

        Commands:
          pull              Download MP3 files from everyayah.com.
          ls                List recitation authors.
          extract-slots     Extract time slots from MP3 files.

* quran-audio pull --help

        Usage: quran-audio pull [OPTIONS]

        Description:
          Download MP3 files from everyayah.com.

        Options:
          -a, --author AUTHOR        An author's name
          -b, --bitrate BITRATE      MP3 bitrate
          -s, --surahs NUMBERS       Comma-separated list of surah numbers
          -d, --delay SECONDS        Delay between requests, in seconds
          -h, --help                 Show help

* quran-audio ls --help

        Usage: quran-audio ls [OPTIONS]

        Description:
          List recitation authors.

        Options:
          -h, --help                 Show help

* quran-audio extract-slots --help

        Usage: quran-audio extract-slots [OPTIONS]

        Description:
          Extract time slots from MP3 files.

        Options:
          -a, --author NAME          An author's name
          -h, --help                 Show help

__Thanks__

First and foremost, Alhamdulillah.

* Thanks to the [everyayah.com](https://everyayah.com) website.
* With thanks (and credit) to the authors:
  * Mishari bin Rashed Alafasy
  * Aziz Alilli
  * Abdullah Awad Al Juhany
  * Ahmad bin Ali Al-Ajmi
  * Sahl Yassin

__License__

The "source code" is released under the [GPL](./LICENSE) license.
