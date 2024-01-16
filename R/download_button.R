#' Make a groovy download button
#'
#' Must enable font awesome to get the icon; this is set up by default in [knitr_setup()].
#' 
#' @param link   Where the button points
#' @param text   What the button says
#' 
#' @export

download_button <- function(link, text="Full results") {
  # VERY IMPORTANT NOT TO INDENT OR PANDOC GETS CONFUSED
  structure(paste0('<a href="', link, '" download="">
<div class="download">
<i class="fas fa-download"></i> ', text, '
</div>
</a>'), class='raw_html')
}

#' @export
print.raw_html <- function(x, ...) cat(x)
