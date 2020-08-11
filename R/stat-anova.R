## One-way ANOVA
htmlANOVA <- function(x, y, Data, plotname=x, xlab=x, ylab=y, ...) {

  if (!missing(Data)) {
    xx <- Data[,x]
    yy <- Data[,y]
  } else {
    xx <- get(x,env=.GlobalEnv)
    yy <- get(y,env=.GlobalEnv)
  }

  if (is.character(yy)) yy <- factor(yy)
  if (is.factor(yy)) yy <- as.numeric(yy)-1
  ind <- is.finite(xx)
  xxx <- factor(xx[ind])
  yyy <- yy[ind]

  fit <- lm(yyy~xxx)
  fit0 <- lm(yyy~1)
  p <- anova(fit0, fit)[2,6]

  visfile <- paste0(.html$img, plotname,"-vis.png")
  png(paste0(.html$dir, visfile), 5, 5, "in", res=200)
  visreg::visreg(fit, "xxx", xlab=xlab, ylab=ylab, ...)
  mtext(formatP(p, label=TRUE), line=0.5)
  dev.off()
  htmlFig(visfile)
}
