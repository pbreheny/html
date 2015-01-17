## One-way ANOVA
htmlANOVA <- function(x, y, Data, plotname=x, xlab=x, ylab=y, ...) {
  filename <- paste0(plotname, ".png")
  require(visreg)
  g <- factor(Data[,x])
  r <- Data[,y]
  fit <- lm(r~g)
  fit0 <- lm(r~1)
  p <- anova(fit0, fit)[2,6]
  png(paste0("html/compiled/", filename), 5, 5, "in", res=200)
  visreg(fit, "g", xlab=xlab, ylab=ylab, ...)
  mtext(formatP(p, label=TRUE), line=0.5)
  dev.off()
  htmlFig(filename)
}
