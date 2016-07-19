webSkeleton <- function(dir) {
  if (missing(dir)) dir <- getOption(htmldir)
  path <- system.file(package="html")
  file.copy(paste0(path, "/web-skeleton"), ".", recursive=TRUE)
  invisible(file.rename("web-skeleton", dir))
}
