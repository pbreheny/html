print.htmlTable <- function(obj, name, file="", append=FALSE, layout='default', ...) {
  if (!missing(name)) file <- paste(.html$dir, name, ".html", sep="")
  if (!append) {
    cat(paste0('---\nlayout: ', layout, '\n---\n'), file=file)
    append <- TRUE
  }
  digits <- if(length(obj@digits)) obj@digits else getOption("digits")
  cat(knitr::kable(obj@table, 'html', table.attr=paste0('class="', obj@htmlClass, '"'), digits=digits, ...),
      file=file, append=append)
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
  digits <- if(length(obj@digits)) obj@digits else getOption("digits")
  x <- kable(X, 'html', table.attr=paste0('class="', obj@htmlClass, '"'), digits=digits, ...)
  new <- paste0('  <tr>\n   <th></th>\n   <th colspan="', ncol(X), '" style="text-align:center;"> ', names(dimnames(X))[2], '</th>\n  </tr>\n')
  x <- gsub('<thead>\n  <tr>', paste0('<thead>\n', new, '  <tr>'), x)
  #x <- gsub("<TR> <TH>", paste("<TR><TD style=\"vertical-align:middle\"rowspan=\"", length(dimnames(X)[[1]])+1, "\"><b>", names(dimnames(X))[1], "</b></TD> <TH>", sep=""),x)
  if (!append) {
    cat(paste0('---\nlayout: ', layout, '\n---\n'), file=file)
    append <- TRUE
  }
  cat(x, file=file, append=append)
}

print.htmlFig <- function(x, name, file="", append=FALSE, layout='default', ...) {
  if (!missing(name)) file <- paste(.html$dir, name, ".html", sep="")
  if (!append) {
    cat(paste0('---\nlayout: ', layout, '\n---\n'), file=file)
    append <- TRUE
  }
  cat("<a href=\"",x@file,"\">","<img src=\"",x@file,"\" height=",x@height," width=",x@width,">","</a>\n", file=file, append=append, sep="")
}
