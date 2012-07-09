## Logistic regression vs. a continuous predictor
lgrCont <- function(x, y, data, plotname=x, reverse=FALSE, xlab.vis=x, ylab.vis=paste("Pr(",y,")",sep=""), tau=signif(sd(xxx),1), log.x=FALSE)
{
  require(visreg)
  if (!missing(data)) {
    xx <- data[,x]
    yy <- data[,y]
  } else {
    xx <- get(x,env=.GlobalEnv)
    yy <- get(y,env=.GlobalEnv)
  }
  if (log.x) {
    plotname
    xx <- log(xx)
    x <- paste("Log(",x,")",sep="")
  }
  
  ## Create boxplot .png
  boxfile <- paste(plotname,"-box.png",sep="")
  png2(paste("html/compiled/",boxfile,sep=""))
  par(las=1)
  boxplot(xx~yy, horizontal=TRUE, pch=19, col="gray90", boxwex=0.5, lwd=0.7, xlab=x, ylab=y)
  ##trellis.par.set(box.rectangle=list(fill="gray90"))
  ##print(bwplot(yy~xx,ylab=y,xlab=x))
  dev.off()
  L <- vector("list",6)
  L[[1]] <- L[[3]] <- htmlText("")
  
  L[[5]] <- htmlFig(boxfile)
  if (is.character(yy)) yy <- factor(yy)
  if (is.factor(yy)) yy <- as.numeric(yy)-1
  ind <- is.finite(xx)
  xxx <- xx[ind]
  yyy <- yy[ind]
  n.missing <- length(xx)-length(xxx)
  if (n.missing > 0) L[[1]] <- htmlText(paste("Missing:",sum(n.missing)))
  fit <- glm(yyy~xxx,family=binomial)
  fit0 <- glm(yyy~1,family=binomial)
  L[[2]] <- htmlText(paste("Odds ratio for<br>difference of ",tau," units",sep=""))
  L[[4]] <- array(NA,dim=c(1,4),dimnames=list(x,c("OR","Lower","Upper","p")))
  L[[4]][1,1] <- exp(tau*coef(fit)[2])
  L[[4]][1,2:3] <- exp(tau*confint(fit,2))
  if (reverse) L[[4]][1:3] <- 1/L[[4]][c(1,3,2)]
  L[[4]][4] <- anova(fit0,fit,test="Chisq")[2,5]
  l <- L[[4]]
  for (j in 1:3) L[[4]][j] <- formatC(l[j],ifelse(l[j]>1,1,2),format="f")
  L[[4]][4] <- formatP(l[4])
  L[[4]] <- htmlTable(L[[4]])
  .pvalues <<- as.numeric(if (exists(".pvalues")) append(.pvalues, l[4]) else l[4])
  
  ## Create visreg .png
  visfile <- paste(plotname,"-vis.png",sep="")
  png2(paste("html/compiled/",visfile,sep=""))
  visreg(fit,xlab=xlab.vis,ylab=ylab.vis,partial=FALSE,scale="response")
  dev.off()
  L[[6]] <- htmlFig(visfile)
  return(htmlList(L))
}
