#' Setup script to be called at beginning of rmarkdown files
#' 
#' Loads knitr, kableExtra, font awesome, sets an RNG seed, and sets several
#' convenient knitr options:
#'   * Aliases for h (fig.height) and w (fig.width)
#'   * Turns on fig.align="center", message=FALSE, etc., almost always what one
#'     wants if writing a report (as opposed to an R instructional document)
#'   * Sets smaller figure margins
#' 
#' @export

knitr_setup <- function() {
  do.call('library', list(package='knitr'))
  do.call('library', list(package='kableExtra'))
  set.seed(1)
  knitr::opts_knit$set(aliases=c(h = 'fig.height', w = 'fig.width'))
  knitr::opts_chunk$set(comment="#", echo=FALSE, message=FALSE, collapse=TRUE, cache=FALSE, tidy=FALSE, fig.align="center")
  knitr::knit_hooks$set(small.mar = function(before, options, envir) {
    if (before) par(mar = c(4, 4, .1, .1))
  })
  htmltools::tagList(rmarkdown::html_dependency_font_awesome())
}
