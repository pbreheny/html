addTop <- function(x,filename)
  {
    val <- c(x,readLines(filename))
    writeLines(val,con=as.character(filename))
    return(val)
  }
