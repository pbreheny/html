## Under construction
## Logistic regression vs. two interacting predictors
htmlModelInt <- function(fBase,x1,x2,...)
{
  if (is.factor(x1) & is.factor(x2)) {
    val <- htmlModelIntCat(fBase,x1,x2,...)
  } else if (is.numeric(x1) & is.factor(x2)) {
    val <- htmlModelIntContCat(fBase,x1,x2,...)
  } else stop("Not supported yet")
  val
}

htmlModelIntCat <- function(fBase,x1,x2,plotname="fit",reverse=FALSE,OR=FALSE,lab)
  {
    xx1 <- factor(x1,levels=rev(levels(x1)))
    xx2 <- factor(x2,levels=rev(levels(x2)))
    cBase <- cBase1 <- cBase2 <- cBase3 <- cBase4 <- as.character(fBase)
    cBase1[3] <- paste(cBase1[3],"+ x1*x2")
    cBase2[3] <- paste(cBase2[3],"+ x1*xx2")
    cBase3[3] <- paste(cBase3[3],"+ xx1*x2")
    cBase4[3] <- paste(cBase4[3],"+ xx1*xx2")
    f1 <- as.formula(paste(cBase1[2],cBase1[1],cBase1[3]))
    f2 <- as.formula(paste(cBase2[2],cBase2[1],cBase2[3]))
    f3 <- as.formula(paste(cBase3[2],cBase3[1],cBase3[3]))
    f4 <- as.formula(paste(cBase4[2],cBase4[1],cBase4[3]))
    fit1 <- glm(f1,family=binomial)
    fit2 <- glm(f2,family=binomial)
    fit3 <- glm(f3,family=binomial)
    fit4 <- glm(f4,family=binomial)
    p <- length(coef(fit1))
    j <- (p-2):p
    B1 <- cbind(coef(fit1)[j],confint(fit1,j),summary(fit1)$coef[j,4])
    B2 <- cbind(coef(fit2)[j],confint(fit2,j),summary(fit2)$coef[j,4])
    B3 <- cbind(coef(fit3)[j],confint(fit3,j),summary(fit3)$coef[j,4])
    ##print(B3)
    B4 <- cbind(coef(fit4)[j],confint(fit4,j),summary(fit4)$coef[j,4])
    B <- rbind(B1[1,],B2[1,],B1[2,],B3[2,],B1[3,])
    colnames(B) <- c("OR","Lower","Upper","p")
    if (!missing(lab)) rownames(B) <- lab
    plotfile <- paste(plotname,".png",sep="")
    heightRatio <- .1+5/10
    png2(paste("html/compiled/",plotfile,sep=""),height=6*heightRatio,width=6)
    CIplot(B,xlab="Difference (log odds)")
    dev.off()
    B[,1:3] <- exp(B[,1:3])
    L <- vector("list",2)
    L[[1]] <- htmlFig(plotfile,height=600*heightRatio,width=600)
    B[,1:3] <- round(B[,1:3],1)
    B[,4] <- formatP(B[,4])
    L[[2]] <- htmlTable(B)
    htmlList(L)
  }

## x1 numeric, x2 factor
htmlModelIntContCat <- function(fBase,x1,x2,ref=quantile(x1,p=c(.25,.75)),plotname="fit",reverse=FALSE,OR=FALSE,lab)
  {
    x11 <- x1-ref[1]
    x12 <- x1-ref[2]
    xx2 <- factor(x2,levels=rev(levels(x2)))
    cBase1 <- cBase2 <- as.character(fBase)
    cBase1[3] <- paste(cBase1[3],"+ x1*x2")
    cBase2[3] <- paste(cBase2[3],"+ x1*xx2")
    f1 <- as.formula(paste(cBase1[2],cBase1[1],cBase1[3]))
    f2 <- as.formula(paste(cBase2[2],cBase2[1],cBase2[3]))
    fit1 <- glm(f1,family=binomial)
    fit2 <- glm(f2,family=binomial)
    p <- length(coef(fit1))
    j <- (p-2):p
    B1 <- cbind(coef(fit1)[j],confint(fit1,j),summary(fit1)$coef[j,4])
    B2 <- cbind(coef(fit2)[j],confint(fit2,j),summary(fit2)$coef[j,4])
    B <- rbind(B1[1,],B2[1,],B1[3,])
    colnames(B) <- c("OR","Lower","Upper","p")
    if (!missing(lab)) rownames(B) <- lab
    plotfile <- paste(plotname,".png",sep="")
    heightRatio <- .1+5/10
    png2(paste("html/compiled/",plotfile,sep=""),height=6*heightRatio,width=6)
    CIplot(B,xlab="Difference (log odds)")
    dev.off()
    B[,1:3] <- exp(B[,1:3])
    L <- vector("list",2)
    L[[1]] <- htmlFig(plotfile,height=600*heightRatio,width=600)
    B[,1:3] <- round(B[,1:3],1)
    B[,4] <- formatP(B[,4])
    L[[2]] <- htmlTable(B)
    htmlList(L)
  }
