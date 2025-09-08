test_that("list_chunks extracts named chunks", {
  tmpfile <- tempfile(fileext = ".Rmd")

  # make a toy Rmd with 2 named chunks and 1 unnamed
  rmd_text <- c(
    "---",
    "title: \"Test Rmd\"",
    "output: html_document",
    "---",
    "",
    "Some text here.",
    "",
    "```{r setup, include=FALSE}",
    "x <- 1",
    "```",
    "",
    "```{r plot1}",
    "plot(x, x)",
    "```",
    "",
    "```{r}",
    "y <- x + 1",
    "```"
  )
  writeLines(rmd_text, tmpfile)

  # call your function
  chunks <- list_chunks(tmpfile)

  # should only return the named ones
  expect_equal(chunks, c("setup", "plot1"))
})

