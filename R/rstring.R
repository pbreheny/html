#' Generate random string of characters
#'
#' @param n        Number of random strings to generate
#' @param length   Number of characters in each random string
#' @param include.extra   Include symbols like !#^*?
#' @param include.num     Include numbers?
#'
#' @examples
#' rstring(1)
#' rstring(5, length=30, include.extra=TRUE)
#'
#' @export

rstring <- function(n=1, length=20, include.extra=FALSE, include.num=FALSE) {
  val <- character(n)
  pool <- c(letters,LETTERS)
  if (include.extra) pool <- c(pool, c("!","@","#","$","%","^","^","&","*","(",")"))
  if (include.num) pool <- c(pool, 0:9)
  for (i in 1:n) {
    val[i] <- paste(sample(pool, length, replace=TRUE), collapse="")
  }
  val
}

#' @export
.link <- function() {
  if (file.exists('.link')) stop('.link file already exists')
  cat(paste0("http://myweb.uiowa.edu/pbreheny/clb/", rstring(1), "/index.html\n"), file=".link")
}
