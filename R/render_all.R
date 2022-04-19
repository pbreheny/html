#' Render all rmd files in the `web` directory
#' 
#' @param files    Files to render (default: `web/*.rmd` if `web` folder exists, otherwise `*.rmd`)
#' @param quiet    As in `rmarkdown::render()`; Default is TRUE.
#' @param ...      Further arguments to `render_page()`
#' 
#' @export

render_all <- function(files, quiet=TRUE, ...) {
  if (missing(files)) {
    if (dir.exists('web')) {
      files <- list.files('web', '*.rmd', full.names=TRUE, ignore.case=TRUE)
      if (dir.exists('web/_site')) unlink('web/_site', recursive=TRUE)
    } else {
      files <- list.files(pattern='*.rmd', full.names=TRUE, ignore.case=TRUE)
    }
  }
  for (f in files) {
    cat('Knitting ', f, '...\n', sep='')
    render_page(f, quiet=quiet, ...)
  }
}
