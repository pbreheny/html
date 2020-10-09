[![GitHub version](https://img.shields.io/static/v1?label=GitHub&message=2.1.4&color=blue&logo=github)](https://github.com/pbreheny/teaching)

# Some helper functions for html page rendering

In development.

## Install

```r
remotes::install_github("pbreheny/html")
```

## Rendering

By render, I mean turn `rmd` into `html`.  To render a single file:

```r
html::render_page('page.rmd')
```

By default, this creates `page.html` in the same directory as `page.rmd`.  If you are publishing to a website, typically you want all the html files in their own directory, which I tend to call `_site` for Jekyll-compatibility.  For this, specify `web=TRUE`:

```r
html::render_page('page.rmd', web=TRUE)
```

To render a bunch of files:

```r
html::render_all(list.files(".", "*.rmd"))'
```

This is basically just a wrapper to `render_page`, but with some options set differently (quieter output, `web=TRUE` by default).

## GitHub pages

To push the web directory to GitHub Pages (assuming you're in a GitHub repo already):

```r
gh_pages('_site')
```
