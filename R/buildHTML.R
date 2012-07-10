buildHTML <- function(java=FALSE)
{
  files <- list.files(.html$dir)
  html.files <- files[grep(".html",files)]
  html.names <- gsub(".html","",html.files)
  for (name in html.names){compileHTML(name,java)}
  css <- paste(.html$dir,"compiled/style.css",sep="")
  if (!file.exists(css)) file.copy(system.file("style.css", package="html"), css)
  js <- paste(.html$dir,"compiled/java.js",sep="")
  if (java & !file.exists(js)) file.copy(system.file("java.js", package="html"), js)
  invisible(NULL)
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
  if (java) {
    buffer <- readLines(system.file("java.html", package="html"))
    writeLines(buffer, con=f)
  }
  writeLines("</body>",con=f)
  writeLines("</html>",con=f)
  close(f)
}
