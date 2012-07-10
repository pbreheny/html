png2 <- function(filename = "Rplot%03d.png",width=7,height=7,res=4,...)
  {
    png(filename=filename,width=480*width/7*res,height=480*height/7*res,res=72*res,...)
  }
