#' Push a flat repository to the GitHub pages branch
#' 
#' Assumes you are in the project home (the one with the `.git` directory), and that a subdirectory contains the web materials.
#' 
#' Flat repository means the history is wiped; this is desirable if the html directory is automatically generated.
#' 
#' @param dir     The subdirectory containing the web materials to be pushed to `gh-pages`
#' @param files   Optional: a vector of filenames, in the case of a partial push.
#' 
#' @export

gh_pages <- function(dir, files) {
  origin <- system('git remote -v', intern=TRUE)[1] %>%
    stringr::str_split('[:space:]') %>%
    magrittr::extract2(1) %>%
    magrittr::extract2(2)
  sha <- system('git rev-parse HEAD', intern=TRUE)[1] %>% stringr::str_sub(1, 7)
  if (!missing(files)) {
    for (f in files) if (!file.exists(paste0(dir, '/', f))) stop(paste('File', f, 'does not exist; remember to specify files relative to current (root) directory.'))
    tmp <- tempdir()
    system(paste('git clone', origin, tmp))
    for (f in files) file.copy(paste0(dir, '/', f), paste0(tmp, '/', f), overwrite=TRUE)
    dir <- tmp
  }
  orig <- setwd(dir)
  on.exit(setwd(orig))
  system('git init')
  system('git add .')
  system(paste0('git commit -m "Master build: ', sha, '"'))
  cmd = paste0('git push --force --quiet ', origin, ' master:gh-pages')
  system(cmd)
}
