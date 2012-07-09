.html <- list(dir = "html/",
              src.dir = "/peds/html/inst",
              style.css = readLines(paste(src.dir,"style.css",sep="")),
              java.html = readLines(paste(src.dir,"java.html",sep="")),
              java.js = readLines(paste(src.dir,"java.js",sep="")))
