if (requireNamespace("tinytest", quietly=TRUE)) {
  tinytest::test_package(pattern="^[^_].*\\.[rR]$")
}
