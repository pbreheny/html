#' Push a flat repository to the GitHub pages branch
#' 
#' Assumes you are in the project home (the one with the `.git` directory), and that a subdirectory contains the web materials.
#' 
#' Flat repository means the history is wiped; this is desirable if the html directory is automatically generated.
#' 
#' @param dir       The subdirectory containing the web materials to be pushed to `gh-pages`
#' @param files     Optional: a vector of filenames, in the case of a partial push.
#' @param flatten   Delete git history; this is desirable for the gh-pages branch since its history is irrelevant, but super-dangerous if you specify the wrong directory, so be very careful with this.  Turned off by default.
#' 
#' @export

gh_pages <- function(dir, files, flatten=FALSE) {
  origin <- system('git remote -v', intern=TRUE)[1] %>%
    stringr::str_split('[:space:]') %>%
    magrittr::extract2(1) %>%
    magrittr::extract2(2)
  sha <- system('git rev-parse HEAD', intern=TRUE)[1] %>% stringr::str_sub(1, 7)
  if (!missing(files)) {
    for (f in files) if (!file.exists(paste0(dir, '/', f))) stop(paste('File', f, 'does not exist; remember to specify files relative to current (root) directory.'))
    tmp <- tempdir()
    system(paste('git clone', origin, tmp))
    orig <- setwd(tmp)
    on.exit(setwd(orig))
    system('git checkout gh-pages')
    setwd(orig)
    for (f in files) file.copy(paste0(dir, '/', f), paste0(tmp, '/', f), overwrite=TRUE)
    setwd(tmp)
    if (flatten) unlink('.git', recursive=TRUE, force=TRUE)
    system('git init')
    system('git add .')
    system(paste0('git commit -m "Updating ', files[1], '..."'))
  } else {
    orig <- setwd(dir)
    on.exit(setwd(orig))
    if (flatten) unlink('.git', recursive=TRUE, force=TRUE)
    system('git init')
    system('git add .')
    system(paste0('git commit -m "Master build: ', sha, '"'))
  }
  cmd = paste0('git push --force --quiet ', origin, ' master:gh-pages')
  system(cmd)
}
