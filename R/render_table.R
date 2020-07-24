#' Render multiple rmd files with input coming from a table
#' 
#' @param Table        Either a `data.frame`-like object or a file name (in which case `fread()` is used to read the file).  Must contain a column called ID that specifies a unique output filename.
#' @param outDir       Where to write the output.  Default: web
#' @param layout_dir   Where are the layouts?  Default: `web/_layouts'
#' 
#' @export

render_table <- function(Table, outDir = 'web', layout_dir = 'web/_layouts') {
  if (is.character(Table)) {
    if (!file.exists(Table)) stop(paste0('File ', Table, ' does not exist'), call.=FALSE)
    Table <- data.table::fread(Table)
  }
  if (!inherits(Table, 'data.frame')) stop('Table must be a data.frame-like object', call.=FALSE)
  if (!('ID' %in% names(Table))) stop('Table must contain a column called "ID"', call.=FALSE)
  for (i in nrow(Table)) {
    v <- as.list(Table[i,])
    out <- paste0(outDir, '/', Table$ID[i], '.rmd')
    x <- readLines(paste0(layout_dir, '/', v$layout, '.rmd'))
    writeLines(whisker::whisker.render(x, v), out)
  }
}
