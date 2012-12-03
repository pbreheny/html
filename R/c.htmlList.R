htmlc <- function(...) {
  val <- c(...)
  as.htmlList(val)
}
as.htmlList <- function(l) {
  ll <- unlist(lapply(l, function(x) {if (class(x)=="htmlList") x@list else x}))
  htmlList(ll)
}
