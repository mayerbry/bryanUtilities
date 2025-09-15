#' Source an R Markdown file
#'
#' Extracts and executes all R code chunks from an R Markdown file,
#' similar to [base::source()] but for `.Rmd`. Only chunks with `eval = TRUE`
#' are included (the same ones that would run when knitting).
#'
#' By default, code is evaluated in the global environment (`.GlobalEnv`),
#' which mimics the most common interactive use of [base::source()]. You can
#' override this with the `envir` argument to isolate execution.
#'
#' @param file Path to the `.Rmd` file.
#' @param envir Environment in which to evaluate the code.
#'   Defaults to the global environment (`.GlobalEnv`).
#' @param chdir Logical; if `TRUE`, the working directory is temporarily
#'   changed to the location of `file` before sourcing, and reset afterwards.
#'   Defaults to `FALSE`.
#'
#' @return Invisibly returns the result of [base::source()].
#'   Side effect: evaluated objects are created in \code{envir}.
#'
#' @examples
#' \dontrun{
#' # Interactive use: objects go into the global environment
#' source_rmd("analysis.Rmd")
#'
#' # Run into a custom environment
#' e <- new.env()
#' source_rmd("analysis.Rmd", envir = e)
#' ls(e)
#'
#' # Respect relative paths inside the Rmd
#' source_rmd("analysis.Rmd", chdir = TRUE)
#' }
#'
#' @export
source_rmd <- function(file, envir = .GlobalEnv, chdir = FALSE) {
  if (chdir) {
    owd <- setwd(dirname(normalizePath(file)))
    on.exit(setwd(owd), add = TRUE)
  }
  tmp <- tempfile(fileext = ".R")
  knitr::purl(file, output = tmp, documentation = 0, quiet = TRUE)
  source(tmp, local = envir, chdir = FALSE)
}
