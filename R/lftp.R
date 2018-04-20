lftp <- function() {
  stop("lftp should be updated!")
  seed <- rstring()

  # sync
  cat("#!/bin/bash\nlftp -f .websync\n", file="sync")

  # .websync
  cat("open -p 22 sftp://sftp.iowa.uiowa.edu\n", file=".websync")
  cat(paste0("mirror --reverse --delete --only-newer web/_site myweb/pbreheny/clb/", seed, "\n"), file=".websync", append=TRUE)

  # .link
  cat(paste0("http://myweb.uiowa.edu/pbreheny/clb/", seed, "/index.html\n"), file=".link")
}
