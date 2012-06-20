toHTML.table <- function(x,class="ctable",...)
  {
    require(xtable)
    display <- xtable(x,digits=attr(x,"digits"))
    align(display) <- c("l",rep("r",ncol(x)))
    print(display,type="html",html.table.attributes=paste("class=",class,sep=""),...)
  }
toHTML.list <- function(x,file="",append=FALSE,align="left")
  {
    cat("<TABLE class=\"container\">\n",file=file,append=append,sep="")
    for (i in 1:length(x))
      {
        cat("<TR><TD align=\"",align,"\">\n",file=file,append=TRUE,sep="")
        toHTML(x[[i]],file=file,append=TRUE)
        cat("</TD></TR>\n",file=file,append=TRUE,sep="")
      }
    cat("</TABLE>\n",file=file,append=TRUE,sep="")
  }
toHTML.character <- function(x,file="",append=FALSE)
  {
    cat("<img src=\"img/",x,"\">\n",file=file,append=append,sep="")
  }
toHTML.matrix <- function(...) toHTML.table(...)
toHTML.array <- function(...) toHTML.table(...)
toHTML.data.frame <- function(...) toHTML.table(...)
toHTML <- function(obj,...) UseMethod("toHTML")
toHTML.crossClass <- function(X,removeZeros=FALSE,file="",append=FALSE,margins=TRUE,...)
  {
    if (removeZeros)
      {
        X <- X[which(apply(X,1,sum)!=0),]
        X <- X[,which(apply(X,2,sum)!=0)]
      }
    if (margins)
      {
        dn <- dimnames(X)
        X <- cbind(X,margin.table(X,1))
        X <- rbind(X,margin.table(X,2))
        rownames(X)[nrow(X)] <- "Total"
        colnames(X)[ncol(X)] <- "Total"
        names(dimnames(X)) <- names(dn)
      }
    x <- toHTML.table(X,only.contents=TRUE,file="|false",...)
    x <- gsub("<TR> <TH>",paste("<TR><TD style=\"vertical-align:middle\"rowspan=\"",length(dimnames(X)[[1]])+1,"\"><b>",names(dimnames(X))[1],"</b></TD> <TH>",sep=""),x)
    for (i in 1:length(dimnames(X)[[1]]))
      {
        x <- gsub(paste("<TR> <TD>",dimnames(X)[[1]][i],"</TD>"),paste("<TR> <TH>",dimnames(X)[[1]][i],"</TD>"),x)
      }
    cat("<TABLE class=\"ctable\">\n",file=file,append=append)
    cat(paste("<TR><TD></TD><TD></TD><TD align=\"center\" colspan=",length(dimnames(X)[[2]]),"><b>",names(dimnames(X))[2],"</b></TD></TR>\n",sep=""),file=file,append=TRUE)
    cat(x,file=file,append=TRUE)
    cat("</TABLE>\n",file=file,append=TRUE)
  }
