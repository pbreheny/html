pushTable <- function(X,class="ctable",...)
  {
    return(rbind(c("",dimnames(X)[[2]]),cbind(dimnames(X)[[1]],X)))
  }
