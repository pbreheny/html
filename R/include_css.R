#' Creates a css doc
#'
#' @param dir     Where to put the child rmd document (default: '_include')
#' @param quiet   Don't print any output (default: FALSE)
#' 
#' @examples
#' \dontrun{
#' include_setup()
#' }
#'
#' @export

include_css <- function(dir='_include', quiet=FALSE) {
  dir <- trimws(dir, whitespace='[\\h\\v/]')
  if (!dir.exists(dir)) dir.create(dir)
  f <- paste0(dir, '/style.css')
  if (file.exists(f)) stop(paste0('Exiting; ', f, ' already exists.'), call.=FALSE)
  file.copy(system.file('html-demo/_include/style.css', package='html'), f)
  if (!file.exists('_output.yml')) file.copy(system.file('html-demo/_include/style.css', package='html'), f)
  
  if (!quiet) {
    paste0('css file written to ', f)
    paste0('Setup code written to ', f)
  }
}
