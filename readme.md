[![GitHub version](https://img.shields.io/static/v1?label=GitHub&message=2.3.0&color=blue&logo=github)](https://github.com/pbreheny/html)

# Some helper functions for html page rendering

In development!

## Install

```r
remotes::install_github("pbreheny/html")
```

## Overview

The purpose of the **html** package is to provide a convenient method for rendering Rmarkdown files into html (turning `a.rmd` into `a.html`). The underlying rendering is done by the **[rmarkdown](https://cran.r-project.org/package=rmarkdown)** package, but **html** handles input/output directories and provides some convienent add-ons.

The package is set up for three specific use cases:

1. Single `.rmd` file: For simple projects that consist of a single Rmarkdown file,

```r
html::render_page('page.rmd')
```

This creates `page.html` in the same directory as `page.rmd`. If there are multiple `.rmd` files in the same directory, it quickly becomes very disorganized to have both `.rmd` pages and `.html` pages in the same directory, so `render_page()` will throw an error in these situations. This can be turned off with `force=TRUE`.

2. GitHub pages: GitHub pages expects that html documents are located in a directory called `docs`. If this directory exists, then the rendered `.html` file appears there instead:

```r
html::render_page('page.rmd')
```

This creates the file `/docs/page.html` if the `docs` folder exists.

3. Jekyll: The expectation here is that the `.rmd` files are in a folder called `web` and the rendered html will appear in a folder called `web/_site`, which will then be hosted locally or by some service provider:

```r
html::render_page('web/page.rmd')
```

This creates the file `web/_site/page.html`. Note that in this case, the `.rmd` file is located in a `web` subdirectory, but all code (both the call to `render_page()` and all code in the `.rmd` file) is run from the project's root directory.

## Batch usage

To render a bunch of files:

```r
html::render_all()
```

If a `web` directory exists, this renders all the `.rmd` files in it; otherwise all the files in the project root. One can also supply a list of files to render. This is essentially a wrapper to `render_page`, but with quieter output.
