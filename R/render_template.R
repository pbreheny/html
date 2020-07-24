#' Render a list of variables, including layout, to an rmd file for rendering
#' 
#' @param v            A list of variables that the template uses; must contain `layout`
#' @param out          Where to write the output.  Default: stdout
#' @param layout_dir   Where are the layouts?  Default: `web/_layouts'
#' 
#' @export

render_template <- function(v, out=stdout(), layout_dir = 'web/_layouts') {
  if (!is.list(v)) stop('v must be a list', call.=FALSE)
  if (!('layout' %in% names(v))) stop('v must contain "layout"', call.=FALSE)
  
  x <- readLines(paste0(layout_dir, '/', v$layout, '.rmd'))
  writeLines(whisker::whisker.render(x, v), out)
}
