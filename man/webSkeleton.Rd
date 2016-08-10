\name{webSkeleton}
\alias{webSkeleton}
\title{Create a skeleton for the website}
\description{
Creates a directory with appropriate structure for you to populate with content.
}
\usage{
webSkeleton(dir)
}
\arguments{
  \item{dir}{The path to the directory you wish to create.  By default, this is
  taken from \code{htmlOpt("dir")}.}
}
\value{
Creates files and directories as a side-effect; returns nothing.
}
\author{Patrick Breheny}
\examples{
webSkeleton()
}
