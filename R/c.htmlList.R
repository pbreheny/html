c.htmlList <- function(..., recursive=FALSE)
{
  htmlList(unlist(lapply(list(...), function(x){x@list})))
}
as.htmlList <- function(l)
{
  ll <- unlist(lapply(l, function(x) {if (class(x)=="htmlList") x@list else x}))
  htmlList(ll)
}
