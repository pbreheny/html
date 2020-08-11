## Linear regression vs. a continuous predictor (simple linear regression)
lmCont <- function(x, y, data, plotname=x, reverse=FALSE, xlab.vis=x, ylab.vis=y, tau=signif(sd(xxx),1),
                   log.x=FALSE, add.mean=FALSE) {
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

  if (is.character(yy)) yy <- factor(yy)
  if (is.factor(yy)) yy <- as.numeric(yy)-1
  ind <- is.finite(xx)
  xxx <- xx[ind]
  yyy <- yy[ind]

  L <- vector("list", 4)
  n.missing <- length(xx)-length(xxx)
  if (n.missing > 0) {
    L[[1]] <- htmlText(paste("Observed:", length(xxx), "<br>\nMissing:", n.missing, "<br>\n"))
  } else {
    L[[1]] <- htmlText("")
  }

  fit <- cor.test(xxx, yyy)
  Tab <- c(fit$estimate, fit$conf.int, fit$p.value)
  Tab <- c(formatC(Tab[1:3], 2, format="f"),
           formatP(Tab[4]))
  L[[2]] <- htmlTable(matrix(Tab, 1, 4, dimnames=list(x, c("Correlation","Lower","Upper","p"))))

  fit <- lm(yyy~xxx)
  L[[3]] <- htmlText(paste("Increase per <br>", tau, " units", sep=""))
  L[[4]] <- array(NA, dim=c(1,4), dimnames=list(x,c("Difference","Lower","Upper","p")))
  L[[4]][1,1] <- tau*coef(fit)[2]
  L[[4]][1,2:3] <- tau*confint(fit,2)
  if (reverse) L[[4]][1:3] <- 1/L[[4]][c(1,3,2)]
  L[[4]][4] <- summary(fit)$coef[2,4]
  l <- L[[4]]
  if (!exists(".B", envir=.GlobalEnv)) {
    assign(".B", l, envir=.GlobalEnv)
  } else {
    B <- get(".B", envir=.GlobalEnv)
    assign(".B", rbind(B,l), envir=.GlobalEnv)
  }
  for (j in 1:3) L[[4]][j] <- formatC(l[j], 2, format="f")
  L[[4]][4] <- formatP(l[4])
  L[[4]] <- htmlTable(L[[4]])
  .pvalues <<- as.numeric(if (exists(".pvalues")) append(.pvalues, l[4]) else l[4])

  ## Create visreg .png
  visfile <- paste0(.html$img, plotname,"-vis.png")
  png(paste0(.html$dir, visfile), 7, 7, "in", res=200)
  visreg::visreg(fit, xlab=xlab.vis, ylab=ylab.vis, partial=TRUE)
  dev.off()
  L[[5]] <- htmlFig(visfile)
  return(htmlList(L))
}
