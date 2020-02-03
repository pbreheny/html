#' Build website
#' 
#' @param complete   Build entire website from scratch?  By default, only rmd files with newer modification times are built
#' @param purl       Deposit .R files in _R folder?  Default is true.
#' 
#' @export

make <- function(complete=FALSE, purl=TRUE) {
  
  # If complete, clean existing output directories
  if (complete) {
    if (dir.exists('web/_site')) {
      unlink('web/_site', recursive=TRUE)
      dir.create('web/_site')
    }
    if (dir.exists('web/_R')) file.remove(dir('web/_R', pattern='*', full.names=TRUE))
  }
  
  # Loop over input rmd files
  for (f in list.files('web', pattern='*.rmd')) {

    # Check if rmd is new
    out <- stringr::str_replace(f, '\\.rmd', '\\.html')
    t1 <- file.info(paste0('web/', f))$mtime
    t2 <- file.info(paste0('web/_site/', out))$mtime
    if (is.na(t2)) {
      new <- TRUE
    } else if (t1 > t2) {
      new <- TRUE
    } else {
      new <- FALSE
    }
    if (complete) new <- TRUE
    
    # Render
    if (new) render_html(paste0('web/', f), purl=purl)
  }
}
