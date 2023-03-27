__About__

quran-audio is a command-line utility that lets you download
recitations of The Quran from [everyayah.com](https://everyayah.com).
With numerous reciters and separate MP3 files for each ayah, you can
easily download and listen to your favorite recitations. 

__Reciters__

<p align="center">
  <pre>
                          Mishari bin Rashed Alafasy
                          From       Kuwait
                          Bitrates   128, 64 (default = 128)
                          CLI        --reciter alafasy
                          
                          Aziz Alili
                          From       Macedonia
                          Bitrates   128 (default = 128)
                          CLI        --reciter aziz_alili
                          
                          Abdullah Awad Al Juhany
                          From       Saudi Arabia
                          Bitrates   128 (default = 128)
                          CLI        --reciter abdullah_awad_al_juhany
                          
                          Ahmad bin Ali Al-Ajmi
                          From       Saudi Arabia
                          Bitrates   128 (default = 128)
                          CLI        --reciter ahmad_bin_ali_al_ajmi
  </pre>
</p>

__Usage__

```
Usage: quran-audio pull [OPTIONS]
  -h, --help                 Show help
  -r, --reciter NAME         The name of a reciter
  -b, --bitrate BITRATE      MP3 bitrate
  -s, --surah SURAHS         Comma-separated list of surah numbers
  -c, --cooldown SECONDS     Cooldown period between requests
  -p, --print                Prints a list of reciters
```

__Thanks__

First and foremost, Alhamdulillah.

* Thanks to the [everyayah.com](https://everyayah.com) website.
* With thanks, and credit:
  * Mishari bin Rashed Alafasy
  * Aziz Alilli
  * Abdullah Awad Al Juhany
  * Ahmad bin Ali Al-Ajmi

__License__

The "source code" is released under the [GPL](./LICENSE) license.
