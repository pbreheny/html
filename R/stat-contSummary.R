contSummary <- function(x, label=as.character(match.call()[2]), plotname=label, digits=1) {
  Tab <- matrix(NA, 1, 8, dimnames=list(label, c("Mean", "SD", "Min", "25%", "Median", "75%", "Max","Missing")))
  Tab[1,] <- c(mean(x, na.rm=TRUE), sd(x, na.rm=TRUE), fivenum(x), sum(is.na(x)))
  
  stripfile <- paste0(plotname, "-strip.png")
  png(paste("html/compiled/", stripfile, sep=""), 5, 2, "in", res=200)
  par(mar=c(5, 0.5, 0.5, 0.5))
  plot(x, runif(length(x)), pch=16, col=rgb(0,0,0,alpha=0.5), yaxt="n", ylab="", xlab=label, bty="n")
  dev.off()
  
  htmlc(htmlTable(Tab, digits=rep(c(digits,0), c(7,1))), htmlFig(stripfile, height=480*2/5))
}
