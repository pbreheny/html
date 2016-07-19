.html <- list(dir="web/", img="img/")
htmlOpt <- function(...) {
  dots <- list(...)
  if (length(dots)==0) {
    return(.html)
  } else if (is.null(names(dots))) {
    return(unlist(.html[unlist(dots)]))
  } else {
    .html[names(dots)] <- dots
    assignInMyNamespace(".html", .html)
  }
}
