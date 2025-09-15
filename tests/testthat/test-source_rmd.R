test_that("source_rmd works with defaults and options", {
  skip_if_not_installed("knitr")

  # Make a temporary Rmd with a code chunk
  rmd <- tempfile(fileext = ".Rmd")
  writeLines(c(
    "---",
    "title: Test",
    "output: html_document",
    "---",
    "",
    "```{r}",
    "x <- 123",
    "y <- getwd()",
    "```"
  ), rmd)

  # ---- Default: into .GlobalEnv ----
  if (exists("x", envir = .GlobalEnv, inherits = FALSE)) {
    rm("x", envir = .GlobalEnv)
  }
  expect_silent(source_rmd(rmd))
  expect_equal(get("x", envir = .GlobalEnv), 123)
  rm("x", envir = .GlobalEnv)  # clean up after test

  # ---- Custom environment ----
  e <- new.env()
  expect_silent(source_rmd(rmd, envir = e))
  expect_equal(e$x, 123)
  expect_false(exists("x", envir = .GlobalEnv, inherits = FALSE)) # no leakage

  # ---- chdir = TRUE ----
  e2 <- new.env()
  expect_silent(source_rmd(rmd, envir = e2, chdir = TRUE))
  expect_equal(normalizePath(e2$y), normalizePath(dirname(rmd)))
})
