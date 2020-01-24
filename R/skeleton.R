#' Create web skeleton
#'
#' @param dir    Name of directory (default: web)
#'
#' @examples
#' \dontrun{
#' skeleton()
#' }
#'
#' @export

skeleton <- function(dir='web') {
  if (dir.exists(dir)) stop(paste0('Exiting; directory ', dir, ' already exists.'))
  path <- system.file(package="html")
  file.copy(paste0(path, "/skeleton"), ".", recursive=TRUE)
  dir.create('skeleton/_site')
  code <- rstring()
  cat(paste0("http://myweb.uiowa.edu/pbreheny/clb/", code, "/index.html\n"), file="skeleton/.link")
  invisible(file.rename("skeleton", dir))
}
