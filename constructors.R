htmlText <- function(text,align="center",colspan=1,bold=FALSE)
  {
    if (bold) text <- paste("<b>",text,"</b>",sep="")
    return(new("htmlText",
               text=text,
               align=align,
               colspan=colspan))
  }
htmlTable <- function(X,digits=numeric(0),class="ctable")
  {
    if (is.matrix(digits)) digits <- as.numeric(digits)
    return(new("htmlTable",
               table=as.data.frame(X),
               digits=digits,
               htmlClass=class))
  }
htmlList <- function(l)
  {
    n <- 0
    for (i in 1:length(l))
      {
        if (.hasSlot(l[[i]],"colspan")) n <- n + l[[i]]@colspan
        else n <- n + 1
      }
    return(new("htmlList",list=l,n=n))
  }
htmlCross <- function(x,margins=TRUE,digits=numeric(0),removeZeros=TRUE,sortTable=ifelse(nrow(X)>2,TRUE,FALSE))
  {
    ## Add options: removeZeros=FALSE
    X <- as.matrix(x)
    X <- X[apply(is.na(X),1,sum)==0,]
    if (is.matrix(digits)) digits <- as.numeric(digits)
    if (removeZeros) X <- X[apply(X,1,sum)!=0,]
    if (sortTable) X <- X[order(apply(X,1,sum),decreasing=TRUE),]
    return(new("htmlCross",X=X,margins=margins,digits=digits))
  }
htmlFig <- function(x,height=480,width=480)
  {
    return(new("htmlFig",file=x,height=height,width=width))
  }
