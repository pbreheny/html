#' Creates a child rmd with setup and footer code to be used on multiple pages
#'
#' @param dir   Where to put the child rmd document (default: '_include')
#' 
#' @examples
#' \dontrun{
#' include_setup()
#' }
#'
#' @export

include_setup <- function(dir='_include') {
  dir <- trimws(dir, whitespace='[\\h\\v/]')
  if (!dir.exists(dir)) dir.create(dir)
  f <- paste0(dir, '/setup.r')
  if (file.exists(f)) stop(paste0('Exiting; ', f, ' already exists.'), call.=FALSE)
  
  code <- r"(```{r knitr-setup, include=FALSE, purl=FALSE}
html::knitr_setup()
devtools::load_all()
```
  
```{js, echo=FALSE}
$(function() {
  $('.main-container').after($('.footer'));
})
```
  
::: {.footer}
<div class="container" style="max-width: 1200px; border-top: 1px solid #cccccc">
  <span class="text-muted">By AUTHORS</span>
  <span class="text-muted" style="float: right">`r paste0("Last updated ", format(Sys.time(), format="%Y-%m-%d %R"))`</span>
</div>
:::)"
  
  cat(code, file=f)
  paste0('Setup code written to ', f)
}
