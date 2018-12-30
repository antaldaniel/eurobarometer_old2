library (eurobarometer)
library (testthat)
context("Creating canonical var names")


test_that("correct text changes", {
  expect_equal(canonical_name_create ( c("UPPER CASE VAR", "VAR NAME WITH % SYMBOL") ),
  c("upper_case_var", "var_name_with_pct_symbol")
  )
})
