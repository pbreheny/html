## One-way ANOVA
htmlANOVA <- function(x, y, Data, plotname=x, xlab=x, ylab=y, ...)
{
  filename <- paste(plotname, ".png", sep="")
  require(visreg)
  g <- factor(Data[,x])
  r <- Data[,y]
  fit <- lm(r~g)
  fit0 <- lm(r~1)
  p <- anova(fit0, fit)[2,6]
  png2(filename)
  visreg(fit, "g", xlab=x, ylab=y, ...)
  mtext(formatP(p, label=TRUE), line=0.5)
  dev.off()
  htmlFig(filename)
}
