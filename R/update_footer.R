update_footer <- function(filename, yaml) {
  html <- readLines(filename)
  author <- sub(".*author: \"?(.*?)\"?\n.*", "\\1", readChar(yaml, file.info(yaml)$size))
  html <- stringr::str_replace(html, 'By.*</span>', paste0('By ', author, '</span>'))
  html <- stringr::str_replace(html, 'Last updated.*</span>', paste0('Last updated ', Sys.time(), '</span>'))
  writeLines(html, filename)
}
