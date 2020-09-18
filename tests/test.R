if (requireNamespace("tinytest", quietly=TRUE)) {
  tinytest::test_package('html', pattern="^[^_].*\\.[rR]$")
}
