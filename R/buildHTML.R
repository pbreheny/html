buildHTML <- function(java=FALSE)
{
  files <- list.files(.html$dir)
  html.files <- files[grep(".html",files)]
  html.names <- gsub(".html","",html.files)
  for (name in html.names){compileHTML(name,java)}
  writeLines(.html$style.css, con=paste(.html$dir,"compiled/style.css",sep=""))
  if (java) writeLines(.html$java.js, con=paste(.html$dir,"compiled/java.js",sep=""))
}
compileHTML <- function(name, java)
{
  in.file <- paste(.html$dir,name,".html",sep="")
  out.file <- paste(.html$dir,"compiled/",name,".html",sep="")
  f <- file(out.file,"w")
  writeLines("<html>",con=f)
  buffer <- readLines(paste(.html$dir,"src/head.html",sep=""))
  writeLines(buffer,con=f)
  writeLines("<body>",con=f)
  buffer <- readLines(paste(.html$dir,"src/header.html",sep=""))
  writeLines(buffer,con=f)
  writeLines("<div id=\"mainClm\">",con=f)
  buffer <- readLines(in.file)
  writeLines(buffer,con=f)
  writeLines("</div>",con=f)
  buffer <- readLines(paste(.html$dir,"src/sidebar.html",sep=""))
  writeLines(buffer,con=f)
  if (java) writeLines(.html$java.html, con=f)
  writeLines("</body>",con=f)
  writeLines("</html>",con=f)
  close(f)
}
