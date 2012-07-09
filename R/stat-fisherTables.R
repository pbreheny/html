fisherTables <- function(x, y, Data, reverse=FALSE, sortTable={if (nrow(tab)>2) TRUE else FALSE})
{
  ## Extract data
  if (class(x)=="character" & length(x)==1) {
    if (!missing(Data)) {
      tab <- table(Data[,x],Data[,y])
      n.missing <- sum(is.na(Data[,x]))
    } else {
      tab <- table(get(x,env=.GlobalEnv),get(y,env=.GlobalEnv))
      n.missing <- sum(is.na(get(x,env=.GlobalEnv)))
    }
    names(dimnames(tab)) <- c(x,y)
  } else {
    cl <- match.call()
    tab <- do.call(table,list(cl$x,cl$y))
    x <- as.character(cl$x)
    y <- as.character(cl$y)
  }
  
  ## Handle sorting
  if (sortTable) tab <- tab[order(apply(tab,1,sum),decreasing=TRUE),]
  
  R <- vector("list",8)
  R[[1]] <- htmlText("Cross-classification table")
  R[[2]] <- htmlText("Marginal percentages<br>across rows")
  R[[3]] <- htmlCross(tab, sortTable=FALSE)
  R[[4]] <- htmlCross(100*prop.table(tab,1), margins=FALSE, digits=1, sortTable=FALSE)
  R[[6]] <- R[[8]] <- htmlText("")
  if (n.missing > 0) R[[6]] <- htmlText(paste("Missing:",sum(n.missing)))
  tab <- tab[apply(tab,1,sum)>0,]
  exit.status <- try(fit <- fisher.test(tab),silent=TRUE)
  if (class(exit.status)=="try-error") fit <- fisher.test(tab,simulate.p.value=TRUE,B=25000)
  if (is.null(fit$estimate)) {
    R[[5]] <- htmlText("Test for association")
    R[[7]] <- htmlText(formatP(fit$p.value,label=TRUE))
    .pvalues <<- if (exists(".pvalues")) append(.pvalues, fit$p.value) else fit$p.value
  } else {
    R[[5]] <- htmlText("Odds ratio")
    R[[7]] <- array(NA,dim=c(1,4),dimnames=list(x,c("OR","Lower","Upper","p")))
    R[[7]][1,1] <- fit$estimate
    R[[7]][1,2:3] <- fit$conf.int
    R[[7]][1,4] <- fit$p.value
    if (reverse) R[[7]][1:3] <- 1/R[[7]][c(1,3,2)]
    x <- R[[7]][1,]
    for (j in 1:3) R[[7]][1,j] <- formatC(x[j],ifelse(x[j]>1,1,2),format="f")
    R[[7]][,4] <- formatP(x[4])
    R[[7]] <- htmlTable(R[[7]])
    .pvalues <<- as.numeric(if (exists(".pvalues")) append(.pvalues, x[4]) else x[4])
  }
  return(htmlList(R))
}
