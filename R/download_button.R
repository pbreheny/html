#' Make a groovy download button
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
</a>'), class='html')
}
print.html <- function(x) cat(x)
