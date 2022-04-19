tmp <- tempdir()
od <- setwd(tmp)
page_loc <- paste0(od, ifelse(interactive(), '/inst/tinytest/page.rmd', '/page.rmd'))

file.copy(page_loc, 'page.rmd')
render_page('page.rmd', quiet=TRUE)
expect_true(file.exists('page.html'))

file.copy('page.rmd', 'page2.rmd')
expect_error(render_page('page.rmd', quiet=TRUE))
render_page('page2.rmd', quiet=TRUE, force=TRUE)
expect_true(file.exists('page2.html'))
