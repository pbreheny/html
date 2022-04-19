if (requireNamespace("tinytest", quietly=TRUE)) {
  tinytest::test_package('html', pattern="^[^_].*\\.[rR]$", side_effects=list(pwd=FALSE, envvar=FALSE))
}
