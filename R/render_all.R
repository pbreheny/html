#' Render all rmd files in the `web` directory
#' 
#' @param files    Files to knit; default: web/*.rmd
#' @param clean    Remove old files?  Default is TRUE.
#' @param purl     Deposit .R files in _R folder?  Default is TRUE.
#' @param quiet    As in `rmarkdown::render()`; Default is TRUE.
#' 
#' @export

render_all <- function(files=list.files('web', '*.rmd', full.names=TRUE), clean=TRUE, purl=TRUE, quiet=TRUE) {
  if (dir.exists('web/_site')) unlink('web/_site', recursive=TRUE)
  for (f in files) {
    cat('Knitting ', f, '...\n', sep='')
    render_page(f, web=TRUE, purl=purl, quiet=quiet)
  }
}
