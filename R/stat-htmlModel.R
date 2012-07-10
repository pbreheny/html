htmlModel <- function(fit, plotname="fit", reverse=FALSE, OR=FALSE, exclude=NULL, standardize=FALSE)
{
  plotfile <- paste(plotname,".png",sep="")
  if (standardize) {
    tau <- apply(model.matrix(fit), 2, sd)[-1]
    catg <- apply(model.matrix(fit),2,function(x){length(unique(x))})[-1]
    tau[catg==2] <- 1
    print(tau)
    B <- CIplot(fit, exclude=exclude, plot=FALSE, tau=tau)
  } else B <- CIplot(fit, exclude=exclude, plot=FALSE)
  heightRatio <- .1+nrow(B)/10
  png2(paste("html/compiled/",plotfile,sep=""),height=6*heightRatio,width=6)
  CIplot(B,xlab="Regression coefficient")
  dev.off()
  if (OR) {
    colnames(B)[1] <- "OR"
    B[,1:3] <- exp(B[,1:3])
  }
  L <- vector("list",2)
  L[[1]] <- htmlFig(plotfile, height=600*heightRatio, width=600)
  B[,1:3] <- round(B[,1:3],1)
  B[,4] <- formatP(B[,4])
  L[[2]] <- htmlTable(B)
    
  return(htmlList(L))
}
