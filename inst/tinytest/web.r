tmp <- tempdir()
od <- setwd(tmp)
page_loc <- paste0(od, ifelse(interactive(), '/inst/tinytest/page.rmd', '/page.rmd'))
dir.create('web')
file.copy(page_loc, 'web/page.rmd')
render_page('web/page.rmd', quiet=TRUE)
expect_true(file.exists('web/_site/page.html'))
setwd(od)