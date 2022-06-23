#' Creates a demo folder for illustrating the usage of the package
#'
#' @param jekyll  Set up in jekyll format (as opposed to `docs`)? (default: FALSE)
#'
#' @examples
#' \dontrun{
#' demo()
#' }
#'
#' @export

demo <- function(jekyll=FALSE) {
  if (dir.exists('html-demo')) stop(paste0('Exiting; directory "html-demo" already exists.'), call.=FALSE)
  path <- system.file(package="html")
  file.copy(paste0(path, "/html-demo"), '.', recursive=TRUE)
  if (jekyll) {
    dir.create('html-demo/web')
  } else {
    dir.create('html-demo/docs')
  }
}
