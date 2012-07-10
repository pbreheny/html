formatP <- function(p,digits=2,label=FALSE)
  {
    val <- formatC(p,digits=digits,format="f")
    for (d in -(digits:4)) val[p < 10^d] <- paste("<",formatC(10^d))
    if (any(p < .01)) val[substr(val,1,2)=="0."] <- paste("  ",val[substr(val,1,2)=="0."])
    if (label)
      {
        val[p >= 10^(-digits)] <- paste("p =",val[p >= 10^(-digits)])
        val[p < 10^(-digits)] <- paste("p",val[p < 10^(-digits)])
      }
    return(val)
  }
