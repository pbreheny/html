makeSidebar <- function(x) {
  out <- c("<div id=\"sideBar\">")
  for (i in 1:length(x)) {
    if (is.null(x[[i]])) next
    out <- c(out,paste("<ul><h5>",names(x)[i],"</h5>",sep=""))
    for (j in 1:length(x[[i]])) {
      if (is.null(names(x[[i]]))) names(x[[i]]) <- x[[i]]
      out <- c(out,paste("<li><a href=\"",x[[i]][j],".html\">",names(x[[i]])[j],"</a></li>",sep=""))
    }
    out <- c(out,"</ul>")
  }
  out <- c(out,"</div>")
  writeLines(out,"html/src/sidebar.html")
}
