tmp <- tempdir()
file.copy('page.rmd', tmp)
setwd(tmp)
dir.create('docs')
render_page('page.rmd', quiet=TRUE)
expect_true(file.exists('docs/page.html'))
