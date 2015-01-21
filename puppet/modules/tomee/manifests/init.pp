class tomee ($tomeepath, $sourceurl, $tomeearchive) {
  downloader::download { $tomeepath :
    source => $sourceurl, 
    archive => $tomeearchive,
  }
}
