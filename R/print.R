print.htmlTable <- function(X, name, file="", append=FALSE, include.rownames=TRUE, layout='default', ...) {
  require(xtable)
  if (!missing(name)) file <- paste(.html$dir, name, ".html", sep="")
  if (identical(X@digits, numeric(0))) {
    digits <- NULL
  } else if (length(X@digits)==1) {
    digits <- c(0, rep(X@digits, ncol(X@table)))
  } else {
    digits <- drop(matrix(c(0, X@digits), ncol=ncol(X@table)+1))
  }
  display <- xtable(X@table,digits=digits)
  if (!append) {
    cat(paste0('---\nlayout: ', layout, '\n---\n'), file=file)
    append <- TRUE
  }
  if (missing(include.rownames) & class(X@table)[1] == "data.table") {
    include.rownames <- FALSE
    align(display) <- c('l', X@align)
  } else {
    align(display) <- X@align
  }
  print(display, type="html", html.table.attributes=paste("class=",X@htmlClass,sep=""),
        file=file, append=append, include.rownames=include.rownames, ...)
}

print.htmlList <- function(x, name, file="", append=FALSE, align="center", ncol, nrow, layout='default', ...) {
  l <- x@list
  n <- x@n
  if (!missing(name)) file <- paste(.html$dir, name, ".html", sep="")

  ## Set up nrow, ncol
  if (missing(nrow) & missing(ncol)){ncol <- 1;nrow <- x@n}
  if (missing(nrow) & !missing(ncol)){nrow <- x@n %/% ncol + ((x@n %% ncol) != 0)}
  if (!missing(nrow) & missing(ncol)){ncol <- x@n %/% nrow + ((x@n %% nrow) != 0)}

  ## Print
  if (!append) {
    cat(paste0('---\nlayout: ', layout, '\n---\n'), file=file)
    append <- TRUE
  }
  cat("<TABLE class=\"container\">\n", file=file, append=append, sep="")
  i <- 1
  ind <- 1
  repeat {
    cat("<TR>\n", file=file, append=TRUE, sep="")
    j <- 1
    repeat {
      cat("<TD", file=file, append=TRUE, sep="")
      if (.hasSlot(l[[ind]],"align")) {
        cat(" align=\"",l[[ind]]@align,"\"",file=file,append=TRUE,sep="")
      } else cat(" align=\"", align,"\"",file=file,append=TRUE,sep="")
      if (.hasSlot(l[[ind]],"colspan")) cat(" colspan=",l[[ind]]@colspan,file=file,append=TRUE,sep="")
      cat(">\n", file=file, append=TRUE)
      print(l[[ind]], file=file, append=TRUE, ...)
      cat("</TD>\n",file=file,append=TRUE,sep="")
      if (.hasSlot(l[[ind]],"colspan")) j <- j + l[[ind]]@colspan else j <- j + 1
      ind <- ind + 1
      if (j > ncol) break
      if (ind > length(l)) break
    }
    cat("</TR>\n",file=file,append=TRUE,sep="")
    i <- i+1
    if (i > nrow) break
  }
  cat("</TABLE>\n", file=file, append=TRUE, sep="")
}

print.htmlText <- function(x, name, file="", append=FALSE, layout='default', ...) {
  if (!missing(name)) file <- paste(.html$dir, name, ".html", sep="")
  if (!append) {
    cat(paste0('---\nlayout: ', layout, '\n---\n'), file=file)
    append <- TRUE
  }
  cat(x@text, "\n", file=file, append=append, sep="")
}

print.htmlCross <- function(obj, name, file="", append=FALSE, layout='default', ...) {
  require(xtable)
  if (!missing(name)) file <- paste(.html$dir, name, ".html", sep="")
  X <- obj@X
  margins <- obj@margins
  if (margins) {
    dn <- dimnames(X)
    X <- cbind(X,margin.table(X,1))
    X <- rbind(X,margin.table(X,2))
    rownames(X)[nrow(X)] <- "Total"
    colnames(X)[ncol(X)] <- "Total"
    names(dimnames(X)) <- names(dn)
  }
  digits <- if (identical(obj@digits,numeric(0))) NULL else drop(matrix(obj@digits,ncol=ncol(X)+1))
  x <- xtable(X,digits=digits)
  align(x) <- c("l",rep("r",ncol(x)))
  x <- print(x, type="html", only.contents=TRUE, file=tempfile(), ...)
  x <- gsub("<TR> <TH>", paste("<TR><TD style=\"vertical-align:middle\"rowspan=\"", length(dimnames(X)[[1]])+1, "\"><b>", names(dimnames(X))[1], "</b></TD> <TH>", sep=""),x)
  for (i in 1:length(dimnames(X)[[1]])) {
    x <- gsub(paste("<TR> <TD>", dimnames(X)[[1]][i],"</TD>"), paste("<TR> <TH>",dimnames(X)[[1]][i],"</TD>"),x,fixed=TRUE)
  }
  if (!append) {
    cat(paste0('---\nlayout: ', layout, '\n---\n'), file=file)
    append <- TRUE
  }
  cat("<TABLE class=\"ctable\">\n", file=file, append=append)
  cat(paste("<TR><TD></TD><TD></TD><TD align=\"center\" colspan=", length(dimnames(X)[[2]]), "><b>", names(dimnames(X))[2],"</b></TD></TR>\n",sep=""), file=file, append=TRUE)
  cat(x, file=file, append=TRUE)
  cat("</TABLE>\n", file=file, append=TRUE)
}

print.htmlFig <- function(x, name, file="", append=FALSE, layout='default', ...) {
  if (!missing(name)) file <- paste(.html$dir, name, ".html", sep="")
  if (!append) {
    cat(paste0('---\nlayout: ', layout, '\n---\n'), file=file)
    append <- TRUE
  }
  cat("<a href=\"",x@file,"\">","<img src=\"",x@file,"\" height=",x@height," width=",x@width,">","</a>\n", file=file, append=append, sep="")
}
