makeSrc <- function(title, author)
{
  ## Header
  filename <- paste(.html$dir,"src/header.html",sep="")
  cat("<div id=\"header\">\n", file=filename)
  cat("  <h1>", title, "</h1>\n", file=filename, append=TRUE, sep="")
  cat("  <p id=\"description\">By ",author, ", ", as.character(Sys.Date()),"</p>\n", file=filename, append=TRUE, sep="")
  cat("</div>\n", file=filename, append=TRUE)
  
  ## Head
  filename <- paste(.html$dir,"src/head.html",sep="")
  cat("<head>\n", file=filename)
  cat("  <title>", title, "</title>\n", file=filename, append=TRUE, sep="")
  cat("  <style type=\"text/css\">\n", file=filename, append=TRUE, sep="")
  cat("    <!--@import url(\"style.css\");-->\n", file=filename, append=TRUE, sep="")
  cat("  </style>\n</head>\n", file=filename, append=TRUE)
}
