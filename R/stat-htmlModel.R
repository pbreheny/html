htmlModel <- function(fit, plotname="fit", reverse=FALSE, OR=FALSE, exclude=NULL, standardize=FALSE, sort=TRUE, labels=rownames(B)) {
  plotfile <- paste(plotname,".png",sep="")
  if (standardize) {
    tau <- apply(model.matrix(fit), 2, sd)[-1]
    catg <- apply(model.matrix(fit),2,function(x){length(unique(x))})[-1]
    tau[catg==2] <- 1
    B <- CIplot(fit, exclude=exclude, plot=FALSE, tau=tau)
  } else B <- CIplot(fit, exclude=exclude, plot=FALSE)
  heightRatio <- .1+nrow(B)/10
  png(paste("html/compiled/",plotfile,sep=""), height=6*heightRatio, width=6, units="in", res=200)
  xlab <- if (OR) "Odds ratio" else "Regression coefficient"
  CIplot(B, xlab=xlab, sort=sort, axis=FALSE, labels=labels)
  if (OR) {
    logAxis(1, base=exp(1), disp=2, n=4)
  } else {
    axis(1)
  }
  dev.off()
  if (OR) {
    colnames(B)[1] <- "OR"
    B[,1:3] <- exp(B[,1:3])
  }
  L <- vector("list",2)
  L[[1]] <- htmlFig(plotfile, height=600*heightRatio, width=600)
  B[,1:3] <- round(B[,1:3],1)
  B[,4] <- formatP(B[,4])
  if (missing(labels)) {
    rownames(B) <- gsub("_", " ", rownames(B))
  } else {
    rownames(B) <- labels
  }
  L[[2]] <- htmlTable(B)
    
  return(htmlList(L))
}
