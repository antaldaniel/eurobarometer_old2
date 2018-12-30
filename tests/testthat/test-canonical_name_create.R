library (eurobarometer)
library (testthat)
context("Creating canonical var names")

canonical_name_create ( c("UPPER CASE VAR", "VAR NAME WITH % SYMBOL") )

test_that("correct text changes", {
  expect_equal(code_nuts1  ( c("UPPER CASE VAR", "VAR NAME WITH % SYMBOL") ),
  c("upper_case_var", "var_name_with_pct_symbol")
  )
})
