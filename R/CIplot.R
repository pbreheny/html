CIplot.matrix <- function(B, labels=rownames(B), pxlim, xlim, ylim, sub, diff=(ncol(B)==4), n.ticks=6, mar=c(5,nn/3+.5,2,4), axis=TRUE, trans, p.label=FALSE, ...)
{
  nn <- max(nchar(rownames(B)))
  par(mar=mar)
  n <- nrow(B)
  if (!missing(trans)) B[,1:3] <- trans(B[,1:3])
  
  if (missing(pxlim))
  {
    if (missing(xlim)) pxlim <- pretty(range(B[,2:3]),n=n.ticks-1)
    else pxlim <- pretty(xlim,n=n.ticks-1)
  }
  if (missing(ylim)) ylim <- c(0.5,n+0.5)
  
  plot(B[n:1,1],1:n,xlim = range(pxlim), ylim=ylim, ylab="", axes=FALSE,pch=19,...)
  for (i in 1:n)
  {
    lines(c(B[i,2:3]),c(n-i+1,n-i+1),lwd=2)
    if (diff)
    {
      p <- formatP(B[,4],label=p.label)
      mtext(at=n-i+1,p[i],line=1,side=4,las=1,cex=0.7,adj=0)
    }
    ##if (nchar(p)==6) p <- paste(p,"  ")
    ##if (nchar(p)==7) p <- paste(p," ")
    ##if (diff) mtext(at=n-i+1,p,line=1,side=4,las=1,cex=0.7,adj=.5)
  }
  if (axis) axis(1, pxlim)
  if (diff)
  {
    null <- 0
    if (!missing(trans)) null <- trans(0)
    abline(v=null,col="gray")
  }
  if (!missing(sub)) mtext(sub,3,0,cex=0.8)
  text(x=par("usr")[1],adj=1,y=n:1,labels=labels,xpd=TRUE,cex=.8)
  return(invisible(B))
}
CIplot.lm <- function(fit, intercept=FALSE, xlab="Regression coefficient", exclude=NULL, plot=TRUE, tau, ...)
{
  p <- length(coef(fit))
  j <- if (intercept) 1:p else 2:p
  if (missing(tau)) tau <- 1
  B <- cbind(tau*coef(fit)[j],
             tau*confint(fit,j),
             summary(fit)$coef[j,4])
  colnames(B) <- c("Coef","Lower","Upper","p")
  for (i in seq_along(exclude)) B <- B[-grep(exclude[i],rownames(B)),]
  if (plot) CIplot(B,xlab=xlab,...)
  return(invisible(B))
}
CIplot.glm <- function(obj,...) CIplot.lm(obj,...)
CIplot <- function(obj,...) UseMethod("CIplot")
