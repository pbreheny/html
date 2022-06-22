#' Creates a demo folder for illustrating the usage of the package
#'
#' @param dir     Name of directory (default: html-demo)
#' @param jekyll  Set up in jekyll format (as opposed to `docs`)? (default: FALSE)
#'
#' @examples
#' \dontrun{
#' demo()
#' }
#'
#' @export

demo <- function(dir='html-demo', jekyll=FALSE) {
  if (dir.exists(dir)) stop(paste0('Exiting; directory ', dir, ' already exists.'), call.=FALSE)
  if (dir.exists('__demo')) stop(paste0('Exiting; directory __demo already exists.'), call.=FALSE)
  path <- system.file(package="html")
  file.copy(paste0(path, "/demo"), "__demo", recursive=TRUE)
  if (jekyll) {
    dir.create('__demo/web')
  } else {
    dir.create('__demo/docs')
  }
  invisible(file.rename("__demo", dir))
}
